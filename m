Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVC1Wa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVC1Wa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVC1Wa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:30:58 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:52230 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262095AbVC1Way (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:30:54 -0500
Date: Tue, 29 Mar 2005 00:30:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Wright <chrisw@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isofs: unobfuscate rock.c
Message-ID: <20050328223048.GA2741@pclin040.win.tue.nl>
References: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi> <20050328200252.GN28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328200252.GN28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: kweetal.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 12:02:52PM -0800, Chris Wright wrote:
> * Pekka Enberg (penberg@cs.helsinki.fi) wrote:
> > This patch removes macro obfuscation from fs/isofs/rock.c and cleans it up
> > a bit to make it more readable and maintainable. There are no functional
> > changes, only cleanups. I have only tested this lightly but it passes
> > mount and read on small Rock Ridge enabled ISO image.
> 
> You might want to look at current -mm.  Andrew has a series or 13 or so
> patches that do very similar cleanup.  Perhaps you could start from there?

Good! When Linus asked I audited rock.c and also did rather similar polishing -
it happens automatically if one looks at this code. But it seems everybody is
doing this right now, so I must wait a few weeks and see what got into Linus'
tree. Linus plugged many but not all holes. (Maybe you did more?)

Andries
