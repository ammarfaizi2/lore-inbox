Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRJKN6z>; Thu, 11 Oct 2001 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJKN6f>; Thu, 11 Oct 2001 09:58:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27367 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276347AbRJKN62>;
	Thu, 11 Oct 2001 09:58:28 -0400
Date: Thu, 11 Oct 2001 09:58:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Vincent Sweeney <v.sweeney@dexterus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Lost Partition
In-Reply-To: <3BC5A493.3ED48320@dexterus.com>
Message-ID: <Pine.GSO.4.21.0110110955391.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Vincent Sweeney wrote:

> No luck I'm afraid. The patch applied successfully bit I still get
> exactly the same problem.

Please, do the following:

dd if=/dev/hdb of=p0 bs=512 count=1
dd if=/dev/hdb of=p1 bs=512 count=1 skip=1076355

and mail the contents of p0 and p1.

