Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291271AbSBGU1E>; Thu, 7 Feb 2002 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291274AbSBGU0y>; Thu, 7 Feb 2002 15:26:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61894 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291271AbSBGU0q>;
	Thu, 7 Feb 2002 15:26:46 -0500
Date: Thu, 7 Feb 2002 15:26:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <Pine.LNX.4.33.0202071220040.25114-100000@segfault.osdlab.org>
Message-ID: <Pine.GSO.4.21.0202071526080.25715-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Patrick Mochel wrote:

> It is really nice, but it's too much for the common case. The goal is to 
> have each file export one and only one value. Setting up an iterator is 
> overkill for one value.

You don't have to use the iterator side of that.

