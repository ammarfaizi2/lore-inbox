Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbRFQI0Y>; Sun, 17 Jun 2001 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbRFQI0O>; Sun, 17 Jun 2001 04:26:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37077 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264701AbRFQI0E>;
	Sun, 17 Jun 2001 04:26:04 -0400
Date: Sun, 17 Jun 2001 04:26:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reg:magic number of the filesystem
In-Reply-To: <Pine.LNX.4.10.10106171342310.11021-100000@blrmail>
Message-ID: <Pine.GSO.4.21.0106170423390.13857-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Jun 2001, SATHISH.J wrote:

> Hi,
> 
> Every file system has a magic number. Can you please tell me what for this
> magic number is used. When do we really use this unique magic number of
> the file system and why?

find . -name *.[chS] >/tmp/list
xargs </tmp/list grep -nw s_magic
xargs </tmp/list grep -nw statfs
man 2 statfs
man 2 fstatfs
man 2 ustat

