Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSKLJmC>; Tue, 12 Nov 2002 04:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbSKLJmC>; Tue, 12 Nov 2002 04:42:02 -0500
Received: from [217.167.51.129] ([217.167.51.129]:14281 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266411AbSKLJmB>;
	Tue, 12 Nov 2002 04:42:01 -0500
Subject: Re: 2.5.46 & 2.5.47: Errors in drivers/video/aty128fb.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Priit Laes <amd@tt.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021112084316.GB8703@amd-laptop.mshome.net>
References: <20021112084316.GB8703@amd-laptop.mshome.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Nov 2002 10:51:37 +0100
Message-Id: <1037094697.8907.245.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My configuration is following
> # Frame-buffer support
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FB_VESA=y
> CONFIG_FB_ATY128=y
> when i tried to compile CONFIG_FB_ATY128 as module it also failed with same errors...
> PS. This also happened in 2.5.46, but i didn't bother to report :(

There are fixed versions of the aty128 and radeon fb drivers in
the PPC tree. Paulus is now taking care of aty128fb and will probably
send linus and updated version soon. I did a port of radeonfb but have
been waiting for Ani Joshi, the driver's maintainer, to send it to
Linus.

Ben.

