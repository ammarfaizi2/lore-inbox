Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbREOUEI>; Tue, 15 May 2001 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbREOUD6>; Tue, 15 May 2001 16:03:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10897 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261421AbREOUDx>;
	Tue, 15 May 2001 16:03:53 -0400
Date: Tue, 15 May 2001 16:03:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <9drvss$7pc$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151602430.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 May 2001, H. Peter Anvin wrote:

> isofs wouldn't be too bad as long as struct mapping:struct inode is a
> many-to-one mapping.

Erm... What's wrong with inode->u.isofs_i.my_very_own_address_space ?

