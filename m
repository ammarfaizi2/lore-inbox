Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSGTXrc>; Sat, 20 Jul 2002 19:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317581AbSGTXrb>; Sat, 20 Jul 2002 19:47:31 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:28233 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317580AbSGTXra>; Sat, 20 Jul 2002 19:47:30 -0400
Date: Sat, 20 Jul 2002 17:50:31 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Redefinitions in include/linux/input.h
Message-ID: <Pine.LNX.4.44.0207201745440.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

include/linux/input.h:457:1: warning: "KEY_PLAY" redefined
include/linux/input.h:310:1: warning: this is the location of the previous 
definition
include/linux/input.h:461:1: warning: "KEY_FASTFORWARD" redefined
include/linux/input.h:311:1: warning: this is the location of the previous 
definition

I don't know which keys are correct, but currently KEY_PLAY is defined to 
407, and KEY_FASTFORWARD is 411. We previously defined them to 207/208.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

