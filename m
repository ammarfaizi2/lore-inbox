Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSA2APi>; Mon, 28 Jan 2002 19:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSA2AP3>; Mon, 28 Jan 2002 19:15:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:780 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287827AbSA2APW>;
	Mon, 28 Jan 2002 19:15:22 -0500
Date: Mon, 28 Jan 2002 22:15:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Rik van Riel's vm-rmap
In-Reply-To: <1012263259.1634.3.camel@tiger>
Message-ID: <Pine.LNX.4.33L.0201282214010.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2002, Louis Garcia wrote:

> Should I do the rmap patch first?

Yes.

After that you can patch the low latency patch,
which will give you a reject on vmscan.c

This doesn't matter because:
1) each part of the low latency patch is independant
2) -rmap already has low latency code in vmscan.c

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

