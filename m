Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSBTAiV>; Tue, 19 Feb 2002 19:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSBTAiB>; Tue, 19 Feb 2002 19:38:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:49026 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290666AbSBTAiA>;
	Tue, 19 Feb 2002 19:38:00 -0500
Date: Tue, 19 Feb 2002 19:37:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jakob Kemi <jakob.kemi@telia.com>
cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conve
In-Reply-To: <02022001122600.01789@jakob>
Message-ID: <Pine.GSO.4.21.0202191935530.9938-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Feb 2002, Jakob Kemi wrote:

> this one. Not that speed really matters in this context. I also found a dozen
> or so of different int to hex implementations. In order to reduce code
> duplication and increase the homogeneity of the kernel I think it's a good
> idea to use _one_ implementation.

In that case it will have to be sprintf/sscanf/strtoul, since this stuff is
not going away...

