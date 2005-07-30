Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbVG3QBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVG3QBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVG3QBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:01:35 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:35296 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S262992AbVG3QBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:01:33 -0400
Message-ID: <42EBA482.2040006@schau.com>
Date: Sat, 30 Jul 2005 18:02:10 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com> <42EB9650.8010305@m1k.net> <42EB99D6.1020907@schau.com> <Pine.LNX.4.61.0507300956340.29844@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0507300956340.29844@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Grrr* - it's the mailer (I'm using Mozilla Thunderbird).   I don't
know why it has chosen to fold those two lines.

The section looks like:

+	struct usb_wsl *wsl=urb->context;
+	int id=0, retval;
+
+	switch (urb->status) {
+	case -ECONNRESET:

/brian

Zwane Mwaikambo wrote:
> On Sat, 30 Jul 2005, Brian Schau wrote:
> 
> 
>>Hi Michael (and others),
>>
>>
>>Thanks for the info.   Well, the reason why I didn't inline the patch
>>was due to the size of it - in terms of lines.   However, here it is:
> 
> 
>>+static void wsl_irq_in(struct urb *urb, struct pt_regs *regs)
>>+{
>>+	struct usb_wsl *wsl=urb->context;
>>+	int id=0, retval;
>>+	+	switch (urb->status) { <==========
>>+	case -ECONNRESET:
> 
> 
> There is something wrong with your patch or mailer.
> 
> 
