Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSJVTHz>; Tue, 22 Oct 2002 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264893AbSJVTHy>; Tue, 22 Oct 2002 15:07:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57056 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264889AbSJVTHs>; Tue, 22 Oct 2002 15:07:48 -0400
Date: Tue, 22 Oct 2002 17:13:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L.0210221712460.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Ingo Molnar wrote:

> the attached patch (ontop of 2.5.44-mm2) implements generic (swappable!)
> nonlinear mappings and sys_remap_file_pages() support. Ie. no more
> MAP_LOCKED restrictions and strange pagefault semantics.

The code looks sane, but like Christoph, I'm curious why
we need it.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

