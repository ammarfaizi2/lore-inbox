Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270901AbTGPPA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270900AbTGPPA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:00:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:522 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270898AbTGPPAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:00:22 -0400
Date: Wed, 16 Jul 2003 17:15:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Michael Dransfield <mike@blueroot.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make xconfig segfaults, menuconfig fails
In-Reply-To: <5.1.0.14.0.20030716141023.02753380@212.67.194.181>
Message-ID: <Pine.LNX.4.44.0307161709230.717-100000@serv>
References: <5.1.0.14.0.20030716141023.02753380@212.67.194.181>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Jul 2003, Michael Dransfield wrote:

> Typing 'make xconfig' segfaults - core dump can be sent if you need

Your xconfig output doesn't make any sense, it shouldn't start compiling, 
did you really only 'make xconfig'?
Anyway, a backtrace might be enough. ('gdb scripts/kconfig/qconf',
'r arch/i386/Kconfig', 'bt')

> 'make menuconfig' produces errors and fails (output attached)

You need to install the ncurses devel package.

bye, Roman

