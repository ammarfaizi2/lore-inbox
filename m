Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292887AbSBVPB5>; Fri, 22 Feb 2002 10:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292888AbSBVPBr>; Fri, 22 Feb 2002 10:01:47 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:28578 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S292887AbSBVPBk>;
	Fri, 22 Feb 2002 10:01:40 -0500
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Troy Benjegerdes <hozer@drgw.net>, wli@holomorphy.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <20020207234555.N17426@altus.drgw.net> <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
From: Jes Sorensen <jes@sunsite.dk>
Date: 22 Feb 2002 15:59:46 +0100
In-Reply-To: Anton Altaparmakov's message of "Fri, 08 Feb 2002 19:34:07 +0000"
Message-ID: <d37kp5v9y5.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> writes:

> At 17:57 08/02/02, Troy Benjegerdes wrote:
> >Well, there's a reason I left out CONFIG_M68K deps.. Go tell me where
> >CONFIG_M68K is defined.. ;)
> 
> Appologies, it's in Configure.help but that is not a too useful places to 
> have it. However the kernel seems to be using:
> 
> #if defined(__mc68000__) so just use that instead. Any m68k people reading 
> this care to comment?

__mc68000__ is the correct define, I don't know who put in CONFIG_M68K
but it doesn't belong there.

Jes
