Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCAI0L>; Fri, 1 Mar 2002 03:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310397AbSCAIYI>; Fri, 1 Mar 2002 03:24:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26845 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310405AbSCAISK>;
	Fri, 1 Mar 2002 03:18:10 -0500
Date: Fri, 1 Mar 2002 03:18:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Laurent <laurent@augias.org>
cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Val Henson <val@nmt.edu>,
        "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
In-Reply-To: <E16giF7-0000Gc-00@lsinitam>
Message-ID: <Pine.GSO.4.21.0203010317380.2886-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Mar 2002, Laurent wrote:

> > We already have better mechanism.  Let ->proc_read() die, it's an ugly
> > kludge, breeding overcomplicated code and buffer overflows.
> 
> What better mechanism ??

seq_file.c and seq_file.h.  Grep around for stuff using it.

