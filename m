Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280731AbRKGBip>; Tue, 6 Nov 2001 20:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKGBif>; Tue, 6 Nov 2001 20:38:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27619 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280731AbRKGBi0>;
	Tue, 6 Nov 2001 20:38:26 -0500
Date: Tue, 6 Nov 2001 20:38:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@suse.de>
cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@oss.sgi.comc
Subject: Re: [RFC][PATCH] extended attributes
In-Reply-To: <20011107023218.A4754@wotan.suse.de>
Message-ID: <Pine.GSO.4.21.0111062037210.29465-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Nov 2001, Andi Kleen wrote:

> I think it would be better to have a statefull readdir instead.
> The kernel supports it via the ->private_data field of struct file
> (not through fork,but that looks like a generic vfs bug) 

???  fork() just copies references to struct file.

