Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277265AbRJQW3a>; Wed, 17 Oct 2001 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277266AbRJQW3T>; Wed, 17 Oct 2001 18:29:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:65037 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277265AbRJQW3K>; Wed, 17 Oct 2001 18:29:10 -0400
Date: Wed, 17 Oct 2001 19:27:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: <linux-kernel@vger.kernel.org>, <mantel@suse.de>
Subject: Re: "3.5GB user address space" option.
In-Reply-To: <1981072193242.20011018021819@spylog.com>
Message-ID: <Pine.LNX.4.33L.0110171926270.1554-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Oleg A. Yurlov wrote:

>         How I can use 3.5GB in my apps ? I try malloc() and get
> error on 2G bounce... :-(

You may want to use the 'hoard' memory allocation library,
it seems a bit smarter than glibc's malloc in getting all
the address space your program wants.

1) install libhoard
2) export LD_PRELOAD=libhoard.so
3) run the program

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

