Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSFWUbJ>; Sun, 23 Jun 2002 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFWUbI>; Sun, 23 Jun 2002 16:31:08 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17536 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317112AbSFWUbI>; Sun, 23 Jun 2002 16:31:08 -0400
Date: Sun, 23 Jun 2002 15:31:07 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rudmer van Dijk <rvandijk@science.uva.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
In-Reply-To: <200206232013.g5NKDjf189958@moon.its.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0206231527030.6241-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Rudmer van Dijk wrote:

> patched against 2.5.24-dj1 (one failed hunk) generates errors:
> # make clean
> <snip>
> make -C /aicasm clean
> make: Entering an unknown directory
> make: *** /aicasm: No such file or directory.  Stop.

Grr, I just shouldn't do last minute changes without testing. Anyway, 
I just put a fixed version into the same place 
(patch-2.5.24-kg2.{gz,bz2}).
(It still has some rough edges which need work, but it should at least 
get the job done)

However, I don't see why you get a failed hunk it applies cleanly against 
a bitkeeper v2.5.24 tree here. (Could you mail me the .rej file, 
privately).

Thanks for testing.

--Kai


