Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276175AbRJCMyR>; Wed, 3 Oct 2001 08:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276174AbRJCMx5>; Wed, 3 Oct 2001 08:53:57 -0400
Received: from ns.suse.de ([213.95.15.193]:15891 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276172AbRJCMxu>;
	Wed, 3 Oct 2001 08:53:50 -0400
Date: Wed, 3 Oct 2001 14:54:17 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem ? 
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Rik van Riel wrote:

> Personally I like ext3 a lot.  I've been using it for almost a
> year now and it has never given me trouble.

I've similar experiences with ext3, except for one bad instance
recently when I put it on my laptop. Lots of asserts were triggered,
and on reboot it couldn't find the journal, the superblock,
or the backup superblocks. I spent a few hours trying to get data
back, and eventually gave up and reformatted as ext2.

Alan mentioned this was something to do with the IBM hard disk
having strange write-cache properties that confuse ext3.
I'm not sure if this has been fixed or not yet, but its enough
to make me think twice about trying it on the vaio for a while.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

