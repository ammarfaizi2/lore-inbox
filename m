Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUDXHiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUDXHiq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDXHiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 03:38:46 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51718 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262031AbUDXHio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 03:38:44 -0400
Date: Sat, 24 Apr 2004 09:36:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040424073622.GN596@alpha.home.local>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898834.7040803@techsource.com> <20040424022458.GA16166@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040424022458.GA16166@zero>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 10:24:58PM -0400, Tom Vier wrote:
> On Fri, Apr 23, 2004 at 05:18:44PM -0400, Timothy Miller wrote:
> > In a drive with multiple platters and therefore multiple heads, you 
> > could read/write from all heads simultaneously.  Or is that how they 
> > already do it?
> 
> fwih, there was once a drive that did this. the problem is track alignment.
> these days, you'd need seperate motors for each head.

I think they now all do it. Haven't you noticed that drives with many
platters are always faster than their cousins with fewer platters ? And
I don't speak about access time, but about sequential reads.

Willy

