Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSG1UYr>; Sun, 28 Jul 2002 16:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSG1UYq>; Sun, 28 Jul 2002 16:24:46 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:36201 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317341AbSG1UYj>; Sun, 28 Jul 2002 16:24:39 -0400
Date: Sun, 28 Jul 2002 23:27:43 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020728202743.GY1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Buddy Lumpkin <b.lumpkin@attbi.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20020728065830.GT1465@niksula.cs.hut.fi> <FJEIKLCALBJLPMEOOMECOEAPDAAA.b.lumpkin@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEAPDAAA.b.lumpkin@attbi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 11:48:51AM -0700, you [Buddy Lumpkin] wrote:
> 
> If im willing to spend the money for tons of RAM I shouldn't have to incur
> the overhead of going out to the swap device at all unless I truly get
> short on memory. Don't just assume that it's inevitable that I will have
> to swap at some point.

I don't get it. Why do you insist swap device must not be touched unless the
system is suffering severe memory shortage? If the anonymous pages are only
written out under dire shortage, you'll have to wait longer for memory to
get freed. If you never face the shortage - well, then, you don't. That's
it, no harm done swap-backing the pages. And remember, the fact that
something is written to swap doesn't mean it couldn't still exist in memory.

Why would do you wan't the swap device not to be touched when there's
nothing else going on? I mean, if you don't want the system to use the swap
device, don't configure one.


-- v --

v@iki.fi
