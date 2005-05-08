Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVEHOPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVEHOPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 10:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVEHOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 10:15:53 -0400
Received: from [80.227.59.61] ([80.227.59.61]:8348 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S262869AbVEHOPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 10:15:48 -0400
Message-ID: <427E1F05.9020503@0Bits.COM>
Date: Sun, 08 May 2005 18:15:33 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mail/News Client 1.0+ (X11/20050507)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Your patch (applied to 2.6.11.8) hangs my touchpad mouse totally.
The error i get on bootup

May  8 17:16:58 localhost kernel: ALPS Touchpad (Glidepoint) detected
May  8 17:16:58 localhost kernel: alps.c: Failed to enable absolute mode
May  8 17:16:58 localhost kernel: input: PS/2 ALPS TouchPad on 
isa0060/serio1

without your patch

May  8 18:11:56 localhost kernel: ALPS Touchpad (Dualpoint) detected
May  8 18:11:56 localhost kernel:   Disabling hardware tapping
May  8 18:11:56 localhost kernel: input: AlpsPS/2 ALPS TouchPad on 
isa0060/serio1

and the mouse works fine (except when it goes crazy and jumps all over 
the place). I've been suffering with the problem for a long while on 
this hardware..

Cheers
Mitch
