Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTHVAJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTHVAJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:09:35 -0400
Received: from webmail6.rediffmail.com ([202.54.124.151]:22676 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id S262947AbTHVAJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:09:33 -0400
Date: 22 Aug 2003 00:09:26 -0000
Message-ID: <20030822000926.17486.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "vijayan prabhakaran" <pvijayan@rediffmail.com>
Reply-To: "vijayan prabhakaran" <pvijayan@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Read in ext3
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a doubt on how ext3 handles read in this specific case.

Assume that a page is written to the journal but not yet updated
to its actual location and before updating the actual copy the 
page
gets invalidated. Now if a read comes to the same
data, which block will be read: the journal copy or the actual
copy ?

First of all, will this situation ever occur ? The page will be
marked dirty until it is written to its actual location so it 
may
never get invalidated until it is written to the actual
location!

I appreciate your help.

Since I'm not subscribed to this list, could you please CC your 
answers to my personal mailid.

Thanks.
Vijayan



___________________________________________________
Meet your old school or college friends from
1 Million + database...
Click here to reunite www.batchmates.com/rediff.asp


