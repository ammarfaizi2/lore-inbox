Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSGXN5q>; Wed, 24 Jul 2002 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSGXN5q>; Wed, 24 Jul 2002 09:57:46 -0400
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:36975 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S317072AbSGXN5p>; Wed, 24 Jul 2002 09:57:45 -0400
Date: Wed, 24 Jul 2002 16:00:26 +0200
From: Sven.Riedel@tu-clausthal.de
To: linux-kernel@vger.kernel.org
Subject: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Message-ID: <20020724140026.GE9765@moog.heim1.tu-clausthal.de>
Reply-To: Sven.Riedel@tu-clausthal.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
USB keyboards don't work with recent 2.4.19-preXX (-pre2 works fine for
me, but pre-10 and up don't), as well as int (at least) 2.5.25.
The kernel does find the keyboard during bootup, but doesn't accept any
keypresses. This happens regardless of the UHCI driver selected in
2.4.19 (normal or JE). 
Input core support has been compiled in, as well as the full HID.
Verified on one different machine.

Regs,
Sven
-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Python is merely Perl for those who
                                  prefer Pascal to C" (anon)
