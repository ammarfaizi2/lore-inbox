Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEIVkC>; Thu, 9 May 2002 17:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSEIVkB>; Thu, 9 May 2002 17:40:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50684 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314389AbSEIVkB>; Thu, 9 May 2002 17:40:01 -0400
Subject: Re: x86 question: Can a process have > 3GB memory?
From: Robert Love <rml@tech9.net>
To: tchiwam <tchiwam@ees2.oulu.fi>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Gerrit Huizenga <gh@us.ibm.com>, Clifford White <ctwhite@us.ibm.com>,
        oliendm@us.ibm.com
In-Reply-To: <Pine.LNX.4.44.0205100020140.31628-100000@st0>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 09 May 2002 14:40:10 -0700
Message-Id: <1020980411.880.93.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-09 at 14:24, tchiwam wrote:

> How about other architectures ? like PowerPc.
> Last calculation I did used 11GB of ram (no swap) on a big Number
> Muncher... Would it be nice to use the same code for testing on 32
> architectures with swap ?

All 32-bit architectures have a 4GB address space, 64-bit architectures
obviously have a much bigger one (depends on the arch how many bits are
used for the address space).

PPC obviously does not have the dumb physical memory limitations x86
has, however.

Anyhow, Rik's mmap trick will work on any arch, not just x86.

	Robert Love

