Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291155AbSBMAdR>; Tue, 12 Feb 2002 19:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291157AbSBMAdL>; Tue, 12 Feb 2002 19:33:11 -0500
Received: from dsl-213-023-043-038.arcor-ip.net ([213.23.43.38]:5765 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291155AbSBMAc6>;
	Tue, 12 Feb 2002 19:32:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: File BlockSize
Date: Wed, 13 Feb 2002 01:36:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com> <E16ae3z-0001xO-00@the-village.bc.nu> <20020212205722.GH767@holomorphy.com>
In-Reply-To: <20020212205722.GH767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16anPb-0001Vu-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 12, 2002 09:57 pm, William Lee Irwin III wrote:
> On Tue, Feb 12, 2002 at 02:37:43PM +0000, Alan Cox wrote:
> > Going to a block size bigger than page size causes all sorts of fun with 
> > allocation failures if there are not two pages free adjacent to one another
> > when allocating, and isn't really worth the cost.
> 
> This sounds like fairly severe memory fragmentation, which seems more
> worrisome to me than blocksize constraints. Should I look into that?

This is one of the chronic VM problems that rmap is supposed to cure, at least
it will provide a base on which an active physical defragger can be built.

-- 
Daniel
