Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTA1OQ5>; Tue, 28 Jan 2003 09:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTA1OQ5>; Tue, 28 Jan 2003 09:16:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:55812 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265480AbTA1OQf>;
	Tue, 28 Jan 2003 09:16:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281426.h0SEQRRn001008@darkstar.example.net>
Subject: Re: AW: Bootscreen
To: Raphael_Schmid@CUBUS.COM (Raphael Schmid)
Date: Tue, 28 Jan 2003 14:26:27 +0000 (GMT)
Cc: rob@r-morris.co.uk, Raphael_Schmid@CUBUS.COM, linux-kernel@vger.kernel.org
In-Reply-To: <398E93A81CC5D311901600A0C9F29289469380@cubuss2> from "Raphael Schmid" at Jan 28, 2003 03:11:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wait screen, then just hangs", which would then require an
> > engineer visit, as opposed to, for example, "it says Obtaining IP
> > Address... then hangs"
> I do have a solution for that. Just make the image 640x440 instead
> 640x480, and have the initscripts output on one of the lower lines
> only, always over-writing the previous message. That way, the
> support engineer would know what's going wrong and you'd still have
> a cute picture.

At the moment, the framebuffer reserves a few lines for the Tux icons,
and uses the rest for text.  Why not just modify that code to achieve
what you want, (a large logo, and a text window).

You could do that on the Atari 65XE, have a text mode window at the
bottom of a graphics screen :-)

John
