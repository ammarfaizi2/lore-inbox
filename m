Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHRPwA>; Sun, 18 Aug 2002 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHRPwA>; Sun, 18 Aug 2002 11:52:00 -0400
Received: from host194.steeleye.com ([216.33.1.194]:3595 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315265AbSHRPv7>; Sun, 18 Aug 2002 11:51:59 -0400
Message-Id: <200208181555.g7IFttC04225@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH 2.5.31] i386 subarchitecture division into machine types
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Aug 2002 10:55:55 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code rearranges the arch/i386 directory structure to allow for sliding 
additional non-pc hardware in here in an easily separable (and thus easily 
maintainable) fashion.  The idea is that all the code for the particular 
problem hardware should be able to go in a separate directory with only 
additional build options in config.in.

No significant changes since 2.5.26

it's available at (108k):

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.31.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

And against the dj tree

http://linux-voyager.bkbits.net/arch-split-dj-2.5

James Bottomley



