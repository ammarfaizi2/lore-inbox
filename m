Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSAFNoK>; Sun, 6 Jan 2002 08:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288951AbSAFNoA>; Sun, 6 Jan 2002 08:44:00 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:21166 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288954AbSAFNny>;
	Sun, 6 Jan 2002 08:43:54 -0500
From: dewar@gnat.com
To: dewar@gnat.com, guerby@acm.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106134353.B7091F2FF5@nile.gnat.com>
Date: Sun,  6 Jan 2002 08:43:53 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<I see no distinction between read and write in the text of the Ada standard.
>>

The point is that the implementation of a write has, given your quote from the
RM, pretty much no choice but to do an exactly "correct" write, but for a
read, there is nothing to stop reading MORE than the minimum, the requirement
of atomicity is still met. Now of course in your array example, you are
exactly right, so you could rig up an array with elements surrounding the
one you really want. A bit heavy, but yes, that's a trick that will work.

