Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289330AbSAOAqV>; Mon, 14 Jan 2002 19:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289329AbSAOAqL>; Mon, 14 Jan 2002 19:46:11 -0500
Received: from ns.suse.de ([213.95.15.193]:63236 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289325AbSAOAp7>;
	Mon, 14 Jan 2002 19:45:59 -0500
Date: Tue, 15 Jan 2002 01:45:58 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: results: Remove 8 bytes from struct page on 64bit archs
In-Reply-To: <20020114063531.GC18794@krispykreme>
Message-ID: <Pine.LNX.4.33.0201150145090.23006-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Anton Blanchard wrote:

> To follow up: Alan Modra found and fixed the bug, it seems we were only
> using the optimisation when the arguments were <= 32bit.
> The target we use is RS64a which has a cost of 60 odd instructions
> for divide.

Look forward to seeing the updated benchmarks.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

