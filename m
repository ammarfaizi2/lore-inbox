Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSBXBDR>; Sat, 23 Feb 2002 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSBXBDG>; Sat, 23 Feb 2002 20:03:06 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:24474 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S289025AbSBXBC5>;
	Sat, 23 Feb 2002 20:02:57 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <927.1014507655@ocs3.intra.ocs.com.au>
From: Jes Sorensen <jes@sunsite.dk>
Date: 24 Feb 2002 02:02:09 +0100
In-Reply-To: Keith Owens's message of "Sun, 24 Feb 2002 10:40:55 +1100"
Message-ID: <d3it8nr8tq.fsf@lxplus049.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> So you have arch dependent code which has to be done for all
> architectures before any driver can use it and the code has to be kept
> up to date by each arch maintainer.  Tell me again why the existing
> mechanisms are not working and why we need exceptions?  IOW, what
> existing problem justifies all the extra arch work and maintenance?

Sorry, can't tell you why as I agree wholeheartedly with you. My point
was that even if it was possible to implement exceptions 'for free' on
all architectures, then it's still not what we want in the
kernel. It's just too gross and makes people think about the code the
wrong way.

Cheers,
Jes
