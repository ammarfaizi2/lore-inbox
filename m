Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSHJOuQ>; Sat, 10 Aug 2002 10:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSHJOuQ>; Sat, 10 Aug 2002 10:50:16 -0400
Received: from tomts24.bellnexxia.net ([209.226.175.187]:7093 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317006AbSHJOuP>; Sat, 10 Aug 2002 10:50:15 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: what's the difference between 2.4-IDE and 2.5-IDE in ATA ?
To: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sat, 10 Aug 2002 10:53:37 -0400
References: <20020810134011.GA5404@stargate.lan>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020810145338.2F9DDABB@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4 IDE was (re)written on top of the old ide code by Andre Hendrik.  Seems 
that Andre, who it seems does really understand IDE and its quirks, can be 
a pain to work with...  In early 2.5.x Linus started taking patches from 
Marcin (or Martin) Dalecki.  Since then, with over a 115 patches, Marcin 
has proceeded to rewrite the IDE code.  This has tended to make IDE a bit 
unstable in 2.5.   About 2.5.26ish Jens Axobe got tired of the 2.5 ide 
problems and ported 2.4 ide to 2.5.  This change was picked up in the Dave 
Jones series of kernels - it allows other pieces of the kernel to be tested 
while Marcin works towards a cleaner IDE.

IDE 2.5 is stable for some but not for others (like me) depending on it is
iffy - have backups.  If you do not want to test 2.5 IDE use -dj (Dave is a 
bit behind Linus now due to other work and a much needed vacation)

Ed Tomlinson


 
