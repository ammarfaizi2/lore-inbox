Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310603AbSCMOKQ>; Wed, 13 Mar 2002 09:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310606AbSCMOKF>; Wed, 13 Mar 2002 09:10:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3222 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310603AbSCMOJ6>;
	Wed, 13 Mar 2002 09:09:58 -0500
Date: Wed, 13 Mar 2002 09:09:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Rik van Riel <riel@conectiva.com.br>, Hans Reiser <reiser@namesys.com>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot [PATCH] and
 discussion of Linux testing procedures
In-Reply-To: <3C8F5AC3.6040904@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0203130903470.22930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002, Martin Dalecki wrote:

> You don't understand by accident that sometimes blind untested
> changes serve the purpose of hinting at API changes in
> areas where once doesn't have the slightest opportunity
> of testing? Just simple count how many FS there are out there
> and you should see that there is no chance for "quality"
> testing before submission of advancements there.
> 
> Breakage is the price you have to pay for advancements.
> 
> (I'm not arguing over the particular case in quesiton here.
> I'm just arguing over the proposal.)

Particular case is combination of my screwup, seriously convoluted code
in original and Oleg not sending the fix we'd settled down upon to Linus
(as far as I can tell).

Broken patches _are_ bad and "how many FS are there" is a BS argument.
It _is_ possible to do that right and when it's done wrong - it's a
fuckup of patch author, period.

Proposal is a bit naive, though - in most of the cases fuckups merrily
pass original testing.

