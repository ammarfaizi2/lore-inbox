Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276176AbRJCNCh>; Wed, 3 Oct 2001 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276185AbRJCNC1>; Wed, 3 Oct 2001 09:02:27 -0400
Received: from stine.vestdata.no ([195.204.68.10]:22506 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S276176AbRJCNCX>; Wed, 3 Oct 2001 09:02:23 -0400
Date: Wed, 3 Oct 2001 15:01:45 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Dave Jones <davej@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011003150145.D8709@vestdata.no>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>; from davej@suse.de on Wed, Oct 03, 2001 at 02:54:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 02:54:17PM +0200, Dave Jones wrote:
> Alan mentioned this was something to do with the IBM hard disk
> having strange write-cache properties that confuse ext3.
> I'm not sure if this has been fixed or not yet, but its enough
> to make me think twice about trying it on the vaio for a while.

If a disk is doing write-back caching, it's likely to break all
journaling filesystem and anything else that relies on write ordering.


-- 
Ragnar Kjørstad
Big Storage
