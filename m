Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbREVTZj>; Tue, 22 May 2001 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbREVTZ3>; Tue, 22 May 2001 15:25:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42492 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262739AbREVTZN>;
	Tue, 22 May 2001 15:25:13 -0400
Date: Tue, 22 May 2001 15:25:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Guest section DW <dwguest@win.tue.nl>
cc: Oliver Xymoron <oxymoron@waste.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <20010522212238.A11203@win.tue.nl>
Message-ID: <Pine.GSO.4.21.0105221523550.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Guest section DW wrote:

> One often has to go through all occurrences of a variable or
> field of a struct. That is much easier with cd_hash and cd_dev
> than with hash and dev.
> 
> No, it is a good habit, these prefixes, even though it is no longer
> necessary because of the C compiler. 

True, except for the stuff that should remain local.

