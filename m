Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJ2RGm>; Mon, 29 Oct 2001 12:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRJ2RGc>; Mon, 29 Oct 2001 12:06:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38919 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276576AbRJ2RGP>; Mon, 29 Oct 2001 12:06:15 -0500
Date: Mon, 29 Oct 2001 15:06:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Maxim Timofeyev <tmahome@tma.spb.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mount --bind -o ro /tmp /mnt/tmp
In-Reply-To: <20011029193556.B1354@home.tma.spb.ru>
Message-ID: <Pine.LNX.4.33L.0110291504380.22127-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Maxim Timofeyev wrote:

> Why I can't mounted a r/w /tmp as r/o /mnt/tmp?

Because a filesystem being read-only is something the
kernel keeps track of on a per-superblock basis.

According to Al Viro, doing this on a per mount point
basis will be trivial in the future, once more parts
of the namespace patch will have been integrated into
the kernel.

(and yes, I'm looking forward to that day)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

