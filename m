Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283673AbRLCXq1>; Mon, 3 Dec 2001 18:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282096AbRLCXgc>; Mon, 3 Dec 2001 18:36:32 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:45526 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S284465AbRLCLqs>; Mon, 3 Dec 2001 06:46:48 -0500
Date: Mon, 3 Dec 2001 12:46:40 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: i386 specific slab cache init code
Message-ID: <Pine.LNX.4.33.0112031242440.11663-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a new slab cache in some kernel functions I've changed.
These changes are only visible on the i386 arch.
So my question is: where to put the code that initializes my cache when 
booting the kernel? I don't think that init/main.c is the preferred place 
to put arch-dependent init stuff...

Frank.

