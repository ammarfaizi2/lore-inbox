Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbSJANhO>; Tue, 1 Oct 2002 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSJANhN>; Tue, 1 Oct 2002 09:37:13 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:268 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261634AbSJANhL>; Tue, 1 Oct 2002 09:37:11 -0400
Date: Tue, 1 Oct 2002 14:42:38 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, akpm@digeo.com, oprofile-list@lists.sf.net
Subject: [PATCH][RFC] oprofile for 2.5.40
Message-ID: <20021001134238.GA61095@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a new version of oprofile against 2.5.40.
 
As before, the full patch is available here :
 
http://oprofile.sf.net/oprofile-2.5/oprofile-2.5-all.diff [93k]
 
with usage notes :
 
http://oprofile.sf.net/oprofile-2.5.html
 
and more readable broken-out patches (but not applyable) :
 
http://oprofile.sf.net/oprofile-2.5/

Changes from the last version

o remove the ctx switch hook
o make event buffer be untyped ulong[] and use escapes for changing
  cpu/context/cookie. This reduces the amount of data considerably.
o use EXPORT_SYMBOL_GPL
o more fixes and cleanups

Does anybody want to try this out ?

regards
john
