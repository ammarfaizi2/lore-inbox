Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263745AbRFRHnJ>; Mon, 18 Jun 2001 03:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRFRHmt>; Mon, 18 Jun 2001 03:42:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17819 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263745AbRFRHml>;
	Mon, 18 Jun 2001 03:42:41 -0400
Date: Mon, 18 Jun 2001 03:42:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: function of getname() function
In-Reply-To: <Pine.LNX.4.10.10106181324110.11158-100000@blrmail>
Message-ID: <Pine.GSO.4.21.0106180340490.17557-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, SATHISH.J wrote:

> Hi,
> 
> Sorry if this question is too silly.
> 
> I could not understand what getname(filename) function in the sys_open()
> function is doing. I could not understand from the code what exactly it is
> doing. Please help me with the same.

It allocates a buffer and copies file name from user memory to that buffer.

