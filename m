Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHJMA1>; Sat, 10 Aug 2002 08:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHJMA1>; Sat, 10 Aug 2002 08:00:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7104 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316856AbSHJMA1>;
	Sat, 10 Aug 2002 08:00:27 -0400
Date: Sat, 10 Aug 2002 08:04:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Kurz <shorty@getuid.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: modules missing author name and/or description
In-Reply-To: <20020810091434.GM23894@salem.getuid.de>
Message-ID: <Pine.GSO.4.21.0208100758290.9847-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Aug 2002, Christian Kurz wrote:

> Hi,
> 
> I just played with lsmod and modinfo and noticed that the following
> modules which I use either lack one or both of the information I
> mentioned in the description. The following modules lack the name of the
> author:
 
[snip the list]

Quite a few modules don't _have_ a single author.  MODULE_AUTHOR is
optional and very dubious at that - especially since we already have
a common way to put attributions in there; just look at the comments
in the beginning of almost any file in the tree.

