Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSBMPiK>; Wed, 13 Feb 2002 10:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSBMPiC>; Wed, 13 Feb 2002 10:38:02 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:50888 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S286590AbSBMPhv>; Wed, 13 Feb 2002 10:37:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml] Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.4.33L2.0202121633070.1530-100000@dragon.pdx.osdl.net>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 13 Feb 2002 10:37:34 -0500
In-Reply-To: <Pine.LNX.4.33L2.0202121633070.1530-100000@dragon.pdx.osdl.net>
Message-ID: <9cfadudie9t.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Yes, I can see the gzip header, using 'od'.
> 
> What's an existing tool to strip (delete) bootsect and setup
> from the beginning of [b]zImage, up to the gzip header, so
> that the rest of the file can be piped to gunzip ?
> Otherwise I can write one.

tail +c ?  dd bs=1 skip=... ?

ian
