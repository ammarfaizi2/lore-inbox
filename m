Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDJJkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDJJkP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDJJkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:40:14 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29845 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261455AbVDJJkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:40:09 -0400
To: David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071720.GA23128@jose.lug.udel.edu>
	<Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	<20050409085017.7edf2c9a.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
	<Pine.LNX.4.62.0504100136290.14436@qynat.qvtvafvgr.pbz>
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 10 Apr 2005 02:40:02 -0700
In-Reply-To: <Pine.LNX.4.62.0504100136290.14436@qynat.qvtvafvgr.pbz> (David
 Lang's message of "Sun, 10 Apr 2005 01:39:25 -0700 (PDT)")
Message-ID: <7vzmw7as25.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DL" == David Lang <dlang@digitalinsight.com> writes:

DL> just wanted to point out that recent news shows that sha1 isn't as
DL> good as it was thought to be (far easier to deliberatly create
DL> collisions then it should be)

I suspect there is no need to do so...

  Message-ID: <Pine.LNX.4.58.0504090902170.1267@ppc970.osdl.org>
  From: Linus Torvalds <torvalds@osdl.org>
  Subject: Re: Kernel SCM saga..
  Date: Sat, 9 Apr 2005 09:16:22 -0700 (PDT)

  ...

                  Linus 

  (*) yeah, yeah, I know about the current theoretical case, and I don't
  care. Not only is it theoretical, the way my objects are packed you'd have
  to not just generate the same SHA1 for it, it would have to _also_ still
  be a valid zlib object _and_ get the header to match the "type + length"  
  of object part. IOW, the object validity checks are actually even stricter
  than just "sha1 matches".

