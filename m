Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287599AbSAEIAj>; Sat, 5 Jan 2002 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287602AbSAEIAT>; Sat, 5 Jan 2002 03:00:19 -0500
Received: from gzp.hu ([212.184.222.124]:55310 "EHLO gzp11.gzp")
	by vger.kernel.org with ESMTP id <S287599AbSAEIAP>;
	Sat, 5 Jan 2002 03:00:15 -0500
Date: Sat, 5 Jan 2002 09:00:09 +0100
From: "Gabor Z. Papp" <gzp@myhost.mynet>
To: linux-kernel@vger.kernel.org
Subject: X and console paralell
Message-ID: <20020105080009.GI22314@gzp2.gzp>
In-Reply-To: <20020104233745.GG22314@gzp2.gzp> <Pine.LNX.4.21.0201041604290.8385-100000@dhcp-199-10.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201041604290.8385-100000@dhcp-199-10.nvidia.com>
Organization: gzp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Vojkovich <mvojkovich@nvidia.com>:

| > Plugging extra USB keyboard and mouse would solve the
| > problem, and I would be able to run X and console
| > simultanously?
| 
|    No, both the console and X need a VT.  As far as I can tell
| Linux only lets you have one VT active at any time.  You can
| have a different mouse and keyboard used by the console and
| by X (in theory at least), but I don't think that solves the
| mutual exclusivity of VTs.  
| 
|    Some people may have kernel hacks to allow this sort of
| thing, but I haven't been keeping track of this stuff.  It's
| not an area that I've been involved in.

Any idea? Basically I would like to run 2 monitor, one for X
and one for console paralell, with 1 keyboard/mouse.
Switching between them like with one monitor, but when no
work on the one, I would like to keep the signal on the
unused monitor, eg I would like to see the (not blank) screen.
