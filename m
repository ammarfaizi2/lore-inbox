Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286844AbRL1LPC>; Fri, 28 Dec 2001 06:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286845AbRL1LOw>; Fri, 28 Dec 2001 06:14:52 -0500
Received: from ns.suse.de ([213.95.15.193]:47113 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286844AbRL1LOt>;
	Fri, 28 Dec 2001 06:14:49 -0500
Date: Fri, 28 Dec 2001 12:14:48 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James A Sutherland <james@sutherland.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <T5819437331ac1785ed279@pcow035o.blueyonder.co.uk>
Message-ID: <Pine.LNX.4.33.0112281213100.22038-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, James A Sutherland wrote:

> In the way I'm suggesting, it just simplifies matters a little: rather than
> having to list RG and AV separately for every single file in devfs, just say
> "this new file is part of devfs" and it "inherits" them that way.

gotcha, sounds ok to me, still quite a bit of work to build the database
needed for this, but as several others have pointed out, this would save
so much time for anyone who sends out lots of patches.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

