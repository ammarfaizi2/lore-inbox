Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284393AbRLRSAB>; Tue, 18 Dec 2001 13:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284386AbRLRR7w>; Tue, 18 Dec 2001 12:59:52 -0500
Received: from waste.org ([209.173.204.2]:52205 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S284436AbRLRR7g>;
	Tue, 18 Dec 2001 12:59:36 -0500
Date: Tue, 18 Dec 2001 11:59:21 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF19B@gsny49e.ny.fw.gs.com>
Message-ID: <Pine.LNX.4.40.0112181157480.13118-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Ahmed, Zameer wrote:

> The finicky nature of closed sourced sybase libraries that we are using in
> the custom apps make me ask this question. Will turning off the Nagle
> algorithm in the kernel on the fly, impact performance in any way? or Can we
> have this feature in the kernel in some way?

Nagle isn't there for looks, of course it will affect performance.

Considered LD_PRELOAD?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

