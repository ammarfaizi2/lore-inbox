Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSGQVUu>; Wed, 17 Jul 2002 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGQVUu>; Wed, 17 Jul 2002 17:20:50 -0400
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:19025
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S316664AbSGQVUu>; Wed, 17 Jul 2002 17:20:50 -0400
Message-Id: <200207172123.g6HLNhs06777@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH 2.5.26] i386 arch subdivision into machine types
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jul 2002 16:23:43 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code rearranges the arch/i386 directory structure to allow for sliding 
additional non-pc hardware in here in an easily separable (and thus easily 
maintainable) fashion.  The idea is that all the code for the particular 
problem hardware should be able to go in a separate directory with only 
additional build options in config.in.

This patch finally gets rid of the last five visws specific pieces from 
smpboot.c (at the expense of a smpboot_hook.h header)

it's available at (109k):

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.26.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


