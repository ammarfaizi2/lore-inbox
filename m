Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312899AbSDPMNX>; Tue, 16 Apr 2002 08:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312943AbSDPMNW>; Tue, 16 Apr 2002 08:13:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:49131 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312899AbSDPMNW>; Tue, 16 Apr 2002 08:13:22 -0400
Date: Tue, 16 Apr 2002 14:10:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incremental Patch Building Script
In-Reply-To: <Pine.LNX.4.43.0204160302250.3657-200000@fermi.orbis-terrarum.net>
Message-ID: <Pine.NEB.4.44.0204161404310.12986-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Robin Johnson wrote:

> Hi,
>
> I have written a script to build incremental patches, as found on
> bzimage.org previously. I have written this so that other people will find
> it easier to roll their own incremental patches to use.
>
> Comments/Suggestions on improvement welcome

There's already interdiff from Tim Waugh's patchutils [1] that makes
incremental diffs between patches. And interdiff doesn't need the source
the patches are against (IOW: to make an incremental patch between two
kernel -pre patches you don't need any kernel sources). It's pretty
simple:

  interdiff -z patch-2.4.19-pre6.gz patch-2.4.19-pre7.gz > mydiff

> Please CC me, as I am not subscribed to the list.
>
> Thanks.

cu
Adrian

[1] http://cyberelk.net/tim/data/patchutils/


-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



