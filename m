Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274066AbRISOMI>; Wed, 19 Sep 2001 10:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274067AbRISOL6>; Wed, 19 Sep 2001 10:11:58 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:15366 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S274066AbRISOLu>; Wed, 19 Sep 2001 10:11:50 -0400
Date: Wed, 19 Sep 2001 15:12:08 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: pavel@suse.cz
Subject: Re: Inline docs for bread()
Message-ID: <20010919151208.A90523@compsoc.man.ac.uk>
In-Reply-To: <20010918215356.A11789@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918215356.A11789@bug.ucw.cz>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 09:53:56PM +0200, Pavel Machek wrote:

> -/*
> - * bread() reads a specified block and returns the buffer that contains
> - * it. It returns NULL if the block was unreadable.
> +/**
> + *	bread() - reads a specified block and returns the bh
> + *	@block: number of block
> + *	@size: size (in bytes) to read

You missed describing dev param. The docs script complains at this.

regards
john

-- 
"If you're not part of the problem, you're part of the problem space." 
