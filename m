Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288136AbSAMUkG>; Sun, 13 Jan 2002 15:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288135AbSAMUj4>; Sun, 13 Jan 2002 15:39:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57498 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288127AbSAMUjp>;
	Sun, 13 Jan 2002 15:39:45 -0500
Date: Sun, 13 Jan 2002 15:39:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <m1ofjyqb7t.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Jan 2002, Eric W. Biederman wrote:

> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > This is an update to the initramfs buffer format spec I posted
> > earlier.  The changes are as follows:
> 
> Comments.  Endian issues are not specified, is the data little, big
> or vax endian?

Data is what you put into files, byte-by-byte.  Headers are ASCII.
 
> What is the point of alignment?  If the data starts as 4 byte aligned,
> the 6 byte magic string guarantees the data will be only 2 byte
> aligned.  This isn't good for 32 or 64 bit architectures.

Both data and headers are aligned.  And headers are ascii strings.

