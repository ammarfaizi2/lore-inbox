Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTBYFOY>; Tue, 25 Feb 2003 00:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTBYFOY>; Tue, 25 Feb 2003 00:14:24 -0500
Received: from tapu.f00f.org ([202.49.232.129]:33430 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267656AbTBYFOX>;
	Tue, 25 Feb 2003 00:14:23 -0500
Date: Mon, 24 Feb 2003 21:24:36 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Schwab <schwab@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030225052436.GB18302@f00f.org>
References: <jeu1et5o4i.fsf@sykes.suse.de> <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 02:39:36PM -0800, Linus Torvalds wrote:

> Claiming that you should index an array with a size_t is crap.

it's broken in general; there is *lots* of code which does things like
"foo[-1] = bar" (string parsers for example)


  --cw
