Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSDSPvl>; Fri, 19 Apr 2002 11:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312610AbSDSPvk>; Fri, 19 Apr 2002 11:51:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5651 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312608AbSDSPvk>; Fri, 19 Apr 2002 11:51:40 -0400
Date: Fri, 19 Apr 2002 12:51:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steve Lord <lord@sgi.com>, Andrew Morton <akpm@zip.com.au>,
        Mark Peloquin <peloquin@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <E16yalh-0007JG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44L.0204191251060.7447-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Alan Cox wrote:

> Oh and the unusual block size stuff seems to be quite easy for the bottom
> layers. The horror lurks up higher. Most file systems can't cope (doesn't
> matter too much), isofs can be mixed block size (bletch) but the killer
> seems to be how you mmap a file on a device with 2326 byte sectors sanely..
> (Just say no ?)

mmap() shouldn't be a problem if you manage to stuff the file
into the page cache ;)

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

