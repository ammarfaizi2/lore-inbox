Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSI2TKm>; Sun, 29 Sep 2002 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSI2TKm>; Sun, 29 Sep 2002 15:10:42 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:2834 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261747AbSI2TKl>; Sun, 29 Sep 2002 15:10:41 -0400
Date: Sun, 29 Sep 2002 15:14:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: twaugh@redhat.com, <serial24@macrolink.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <E17viMz-0006UO-00@alf.amelek.gda.pl>
Message-ID: <Pine.LNX.4.44.0209291511250.24805-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Marek Michalkiewicz wrote:

> I haven't heard anything from the kernel people yet - any chances of
> getting these changes into the official 2.4.x source?  I can make
> a second patch (NetMos support) after the first one is accepted...

I submitted both a parport sharing (i am using interrupt driven parport, 
which is needed due to both serial ports using the same irq) and netmos 
patch a while ago, Tim was concerned about issues encountered 
by folks previously wrt the netmos.

Tests run with this setup was copying a cd from a parport cd drive and 
doing heavy serial i/o on both serial ports. the md5sum on the resultant 
cd image was verified.

	Zwane


-- 
function.linuxpower.ca

