Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSDDTwZ>; Thu, 4 Apr 2002 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSDDTwQ>; Thu, 4 Apr 2002 14:52:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46570 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S311424AbSDDTwA>; Thu, 4 Apr 2002 14:52:00 -0500
Date: Thu, 4 Apr 2002 21:50:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0204042146520.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Configure.help contains the help text below that sounds more like a
comment to a patch than a helpful help message for a user of a stable
kernel:

+CONFIG_IDE_TASKFILE_IO
+  This is the "Jewel" of the patch.  It will go away and become the new
+  driver core.  Since all the chipsets/host side hardware deal w/ their
+  exceptions in "their local code" currently, adoption of a
+  standardized data-transport is the only logical solution.
+  Additionally we packetize the requests and gain rapid performance and
+  a reduction in system latency.  Additionally by using a memory struct
+  for the commands we can redirect to a MMIO host hardware in the next
+  generation of controllers, specifically second generation Ultra133
+  and Serial ATA.
+
+  Since this is a major transition, it was deemed necessary to make the
+  driver paths buildable in separtate models.  Therefore if using this
+  option fails for your arch then we need to address the needs for that
+  arch.
+
+  If you want to test this functionality, say Y here.

Could anyone provide a more useful help text?

TIA
Adrian


