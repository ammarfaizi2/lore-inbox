Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUHRBq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUHRBq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268545AbUHRBq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:46:59 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:53161 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268544AbUHRBq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:46:56 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch is this? - Unsure still
Date: Tue, 17 Aug 2004 21:46:58 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408170349.44626.shawn.starr@rogers.com> <200408170402.33368.shawn.starr@rogers.com> <200408170801.00068.dtor_core@ameritech.net>
In-Reply-To: <200408170801.00068.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408172146.58611.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great, it works

On top of that the X driver for the Synaptics device along with qsynaptics (a 
userland GUI tool) all works fine.

Good stuff!

Shawn.

On August 17, 2004 09:01, Dmitry Torokhov wrote:
> On Tuesday 17 August 2004 03:02 am, Shawn Starr wrote:
> > Sorry, I stand corrected. I don't know where this patch is added from
> > which enables the touchpad to act as a 'button press'.
>
> mousedev now does tap emulation for touchpads working in absolute mode
> (Synaptics) so you don't need to use psmouse.proto= parameter to force
> it in PS/2 compatibility mode. Use mousedev.tap_time= option to control
> it.
>
> The patch is only in -mm at the moment.
