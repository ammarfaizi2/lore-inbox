Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTL0VAB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTL0VAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 16:00:00 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:6235 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264591AbTL0U77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:59:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 15:59:52 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Tomas Szepe <szepe@pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <20031227113848.GA10491@louise.pinerecords.com> <Pine.LNX.4.58.0312271755500.29577@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0312271755500.29577@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271559.52155.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 12:56 pm, Marcos D. Marado Torres wrote:
> It kills the mouse tap on an Asus M3700N laptop too...

Mousedev PS/2 emulation for touchpads in absolute mode does not support
taps. You will either have to use Peter Osterlund's XFree86 driver at:
http://w1.894.telia.com/~u89404340/touchpad/index.html
and an updated version of GPM at http://www.geocities.com/dt_or/gpm
or disable native Synaptics support using psmouse_proto option
(bare, imps or exps; any of them should do the trick).

Dmitry
