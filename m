Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbSJVSsp>; Tue, 22 Oct 2002 14:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSJVSsp>; Tue, 22 Oct 2002 14:48:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10717 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264933AbSJVSso>; Tue, 22 Oct 2002 14:48:44 -0400
Date: Tue, 22 Oct 2002 16:54:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Tim Hockin <thockin@sun.com>
Cc: Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
In-Reply-To: <3DB59722.2090701@sun.com>
Message-ID: <Pine.LNX.4.44L.0210221653420.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Tim Hockin wrote:
> Jesse Pollard wrote:
>
> > And I really doubt that anybody has 10000 unique groups (or even
> > close to that) running under any system. The center I'm at has
> > some of the largest UNIX systems ever made, and there are only
> > about 600 unique groups over the entire center. The largest number
> > of groups a user can be in is 32. And nobody even comes close.
>
> I'm glad it doesn't affect you.  If it was a more common problem, it
> would have been solved a long time ago.  It does affect some people,
> though.  Maybe they can redesign their group structures, but why not
> remove this arbitrary limit, since we can?

For anoncvs this is a common problem.

Each project has its own group and the anoncvs user needs
access to all (write access in order to make lock files).

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

