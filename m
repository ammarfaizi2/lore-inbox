Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRLFUNb>; Thu, 6 Dec 2001 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284164AbRLFUNW>; Thu, 6 Dec 2001 15:13:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:32017 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284180AbRLFUNM>; Thu, 6 Dec 2001 15:13:12 -0500
Date: Thu, 6 Dec 2001 18:12:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: list_head makes me crazy
In-Reply-To: <Pine.GSO.4.31.0112062004520.2339-100000@eduserv.rug.ac.be>
Message-ID: <Pine.LNX.4.33L.0112061812380.2283-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Frank Cornelis wrote:

> In include/asm-i386/processor.h, struct thread_struct I can add
> 	struct list_head *mylist;
> but not
> 	struct list_head mylist;

A struct list_head is about twice as large as a pointer.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

