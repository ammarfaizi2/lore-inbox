Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131759AbRCQRyo>; Sat, 17 Mar 2001 12:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbRCQRye>; Sat, 17 Mar 2001 12:54:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47517 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131759AbRCQRyV>;
	Sat, 17 Mar 2001 12:54:21 -0500
Date: Sat, 17 Mar 2001 12:53:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Boris Pisarcik <boris@acheron.sk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <20010317185915.A5154@Boris>
Message-ID: <Pine.GSO.4.21.0103171251330.17004-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Mar 2001, Boris Pisarcik wrote:

> On Thu, Mar 15, 2001 at 11:44:52PM -0300, Rik van Riel wrote:
> i cannot delete executable file when it's just run, but under linux
> i can delete /bin/bash without any problem. 

You can't delete it. You can unlink it, but the file itself remains
alive until the last reference goes away. mapping counts as reference.

