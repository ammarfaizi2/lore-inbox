Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbREVOdn>; Tue, 22 May 2001 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbREVOdd>; Tue, 22 May 2001 10:33:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4619 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261778AbREVOdR>; Tue, 22 May 2001 10:33:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ricardo Galli" <gallir@uib.es>, <linux-kernel@vger.kernel.org>
Subject: Re: New XFS, ReiserFS and Ext2 benchmarks
Date: Tue, 22 May 2001 12:29:13 +0200
X-Mailer: KMail [version 1.2]
Cc: <timothy@monkey.org>, <reiser@namesys.com>,
        "Guillem Cantallops Ramis" <guillem@cantallops.net>
In-Reply-To: <LOEGIBFACGNBNCDJMJMOKEADCJAA.gallir@uib.es>
In-Reply-To: <LOEGIBFACGNBNCDJMJMOKEADCJAA.gallir@uib.es>
MIME-Version: 1.0
Message-Id: <01052212291305.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 04:41, Ricardo Galli wrote:
> Hi,
> 	you can find at http://bulma.lug.net/static/ a few new benchmarks
> among Reiser, XFS and Ext2 (also one with JFS).
>
> This time there is a comprehensive Hans' Mongo benchmarks
> (http://bulma.lug.net/static/mongo/ )and a couple of kernel
> compilations and read/write/fsync operations tests (I was very
> careful of populating the cache before the measures for the last two
> cases).

The measured create and rename times for Ext2 look pretty silly, don't they?
OK, I know that my htree directory index patch isn't part of Ext2 yet, but at 
least lets mention that this is a solved problem.

  http://nl.linux.org/~phillips/htree

--
Daniel
