Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSIXVR3>; Tue, 24 Sep 2002 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSIXVR3>; Tue, 24 Sep 2002 17:17:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64423 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261828AbSIXVR2>; Tue, 24 Sep 2002 17:17:28 -0400
Date: Tue, 24 Sep 2002 18:22:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: David Schwartz <davids@webmaster.com>, <pwaechtler@mac.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <3D90D4B9.9080802@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44L.0209241822080.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Chris Friesen wrote:
> David Schwartz wrote:
>
> > 	The main reason I write multithreaded apps for single CPU systems is to
> > protect against ambush. Consider, for example, a web server. Someone sends it
> > an obscure request that triggers some code that's never run before and has to
> > fault in. If my application were single-threaded, no work could be done until
> > that page faulted in from disk.
>
> This is interesting--I hadn't considered this as most of my work for the
> past while has been on embedded systems with everything pinned in ram.

On an ftp server (or movie server, or ...) you CAN'T pin everything
in RAM.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

