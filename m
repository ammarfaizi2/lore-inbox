Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276155AbRI1Qj6>; Fri, 28 Sep 2001 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276154AbRI1Qji>; Fri, 28 Sep 2001 12:39:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14866 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276155AbRI1Qjc>; Fri, 28 Sep 2001 12:39:32 -0400
Date: Fri, 28 Sep 2001 13:39:40 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <stefan@oph.rwth-aachen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.9-ac16
In-Reply-To: <3BB49788.100E68FD@die-macht.oph.rwth-aachen.de>
Message-ID: <Pine.LNX.4.33L.0109281338590.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Stefan Becker wrote:
> Alan Cox wrote:
> > *       Update the VM to Rik's latest bits
>
> "swapoff -a" gives:
>
> Sep 28 17:25:25 unknown kernel: Trying to vfree() nonexistent vm
> area (e105a000)

It seems Al Viro forgot to remove a free() when cleaning
up some code. Hugh Dickens has already posted a patch to
fix this.

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

