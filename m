Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUIPKuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUIPKuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267901AbUIPKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:49:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267851AbUIPKtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:49:03 -0400
Subject: Re: journal aborted, system read-only
From: "Stephen C. Tweedie" <sct@redhat.com>
To: gene.heskett@verizon.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200409160103.35665.gene.heskett@verizon.net>
References: <200409121128.39947.gene.heskett@verizon.net>
	 <1095088378.2765.18.camel@sisko.scot.redhat.com>
	 <200409160103.35665.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1095331734.1958.3.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Sep 2004 11:48:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-09-16 at 06:03, Gene Heskett wrote:

> >Well, we really need to see _what_ error the journal had encountered
...
> It just did it to me again, this time with 2.6.9-rc1-mm5.

> And as usual in these cases, the logs are spotlessly clean 
> because /var is on /, which is on /dev/hda7, an syslog couldn't write 
> when its read-only.

Possibility the first is to create a separate partition for /var;
possibility the second is to set up a serial console.  Without access to
that log information, all we know is "there was an IO error," and that's
really not enough to narrow down the search. :-)

Thanks,
 Stephen

