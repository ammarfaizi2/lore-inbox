Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUIVHM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUIVHM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIVHM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:12:27 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:51868 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267446AbUIVHMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:12:25 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/3] New input patches
Date: Wed, 22 Sep 2004 02:12:23 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409162358.27678.dtor_core@ameritech.net> <20040921121040.GA1603@ucw.cz> <200409210815.34509.dtor_core@ameritech.net>
In-Reply-To: <200409210815.34509.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409220212.23110.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 08:15 am, Dmitry Torokhov wrote:
> On Tuesday 21 September 2004 07:10 am, Vojtech Pavlik wrote:

> > So the condition needs to be inverted. However, it's not necessary at
> > all, since the input layer will not pass the RAW events when the MSC_RAW
> > bit is not set.
> 
> I see, my bad. I will drop that bit.
> 
> Thanks for the comments!
> 

Vojtech,

I have fixed the aforementioned bug and re-diffed the patches against your
latest tree. Please do:

	bk pull bk://dtor.bkbits.net/input

Thanks!

-- 
Dmitry
