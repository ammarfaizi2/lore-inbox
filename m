Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSDPOLo>; Tue, 16 Apr 2002 10:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313688AbSDPOLn>; Tue, 16 Apr 2002 10:11:43 -0400
Received: from [24.84.50.235] ([24.84.50.235]:11269 "HELO
	mail.orbis-terrarum.net") by vger.kernel.org with SMTP
	id <S313687AbSDPOLm>; Tue, 16 Apr 2002 10:11:42 -0400
Date: Tue, 16 Apr 2002 07:11:46 -0700 (PDT)
From: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incremental Patch Building Script
In-Reply-To: <Pine.NEB.4.44.0204161404310.12986-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.43.0204160710290.12000-100000@fermi.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Adrian Bunk wrote:
>
> There's already interdiff from Tim Waugh's patchutils [1] that makes
> incremental diffs between patches. And interdiff doesn't need the source
> the patches are against (IOW: to make an incremental patch between two
> kernel -pre patches you don't need any kernel sources). It's pretty
> simple:
>
>   interdiff -z patch-2.4.19-pre6.gz patch-2.4.19-pre7.gz > mydiff

I did try interdiff before writing this script, and it wasn't generating
the right output.

-- 
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=people.robbat2
ICQ#       : 30269588 or 41961639

