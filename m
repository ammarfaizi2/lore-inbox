Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSHHS5I>; Thu, 8 Aug 2002 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHHS5I>; Thu, 8 Aug 2002 14:57:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35340 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317844AbSHHS5H>; Thu, 8 Aug 2002 14:57:07 -0400
Date: Thu, 8 Aug 2002 16:00:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <E17csOL-0008L7-00@pmenage-dt.ensim.com>
Message-ID: <Pine.LNX.4.44L.0208081559370.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Paul Menage wrote:

> There are some cases where this might not be true - e.g. in the
> migration code in at least one version of the O(1) scheduler (included
> in RedHat's 2.4.18-4) the migration_lock is taken on one CPU and
> released on another (following an IPI being sent from the CPU that took
> the lock).

Colour me impressed ...

Ingo never ceases to amaze ;)

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

