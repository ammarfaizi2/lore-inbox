Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUKXFmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUKXFmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 00:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKXFml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 00:42:41 -0500
Received: from [81.23.229.73] ([81.23.229.73]:20427 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261960AbUKXFmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 00:42:21 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: papercrane@reversefold.com
Subject: Re: Compact Flash - simulating a card
Date: Wed, 24 Nov 2004 06:42:14 +0100
User-Agent: KMail/1.6.2
References: <432beae04112313344fb4a5f9@mail.gmail.com>
In-Reply-To: <432beae04112313344fb4a5f9@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240642.14660.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually not really of topic, so so much for getting shunted.

Anyway:
If you edit the modules part (manuals enough on the internet, watch your 
kernel version, because modules changed a bit between 2.4 and 2.6 kernels), 
you can force the identifier of your card to be matched with a CF device. 
Take the best matching device. 
If you don't have any match at all, you have a problem, i.e. it will not work.

I don't know the Zaurus (except from a nice picture), so I don't know what 
kind of port is used for the CF card (IDE? PCMCIA? other?). If it is an IDE 
port, it should work at once. It does not need any other information.

For the rest it sounds to me like you are doing a hardware hack. 

Regards,

Norbert

On Tuesday 23 November 2004 22:34, Justin Patrin wrote:
> I am not currently subscribed to this list as I figure I'll be shunted
> to another anyway. Please CC me on replies to this thread. If I should
> be asking "someone else" whether it be another list or group, let me
> know.
>
> I currently have a Sharp Zaurus with OpenZaurus on it. I'm trying to
> connect a device to the CF slot. Would is be possible to fake the CF
> "startup"? I.e. connect a dumb device (which does not understand the
> CF spec itself) but have the kernel able to pass certain requests on
> to it? I have tried connecting the device and it sees it (as I've
> hooked up the detection pins) but something times out. Sorry, I don't
> have the exact message at the moment.
