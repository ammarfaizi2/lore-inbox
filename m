Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXL6T>; Wed, 24 Jan 2001 06:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131180AbRAXL6J>; Wed, 24 Jan 2001 06:58:09 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:56840 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129401AbRAXL5z>; Wed, 24 Jan 2001 06:57:55 -0500
Date: Wed, 24 Jan 2001 12:57:45 +0100 (CET)
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
To: Michael McLeod <michaelm@platypus.net>
cc: Nicholas Dronen <ndronen@frii.com>, <linux-kernel@vger.kernel.org>
Subject: Re: monitoring I/O
In-Reply-To: <20010123175825.A88907@frii.com>
Message-ID: <Pine.LNX.4.30.0101241203110.27495-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Nicholas Dronen wrote:

> Check out the disk_io field in /proc/stat.

Which unfortunately provides only some pieces of information Michael wants
to gather. SCT's sard patches give you much improved statistics that
should basically do what you want. I'm not sure of the current location of
the sard patches but as RedHat puts sard in its kernel, it should be
available somewhere on redhat.com, I suppose. Check out the sysstat
package for userlevel tools. Earlier versions of sard can be found at
ftp.uk.linux.org/pub/linux/sct/fs/profiling/

> On Wed, Jan 24, 2001 at 11:52:36AM +1100, Michael McLeod wrote:
> > I am hoping someone can give me a little information or point me in the
> > right direction.  I would like to write an application that monitors I/O
> > on a linux machine, but I need some help in determining where to get the
> > information I'm looking for.  What I would like to do is 'hook' into the
> > kernel and record information such as volume name, type of request (read
> > or write), the amount of data being read or written, how long each
> > transaction takes....

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
              Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
