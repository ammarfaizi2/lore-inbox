Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTDVBtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDVBtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:49:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17796 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262810AbTDVBtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:49:49 -0400
Date: Tue, 22 Apr 2003 03:01:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030422020153.GA18141@mail.jlokier.co.uk>
References: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl> <b8262k$6t8$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8262k$6t8$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > Well, I have also done that of course. Both struct and u64 work well.
> > Since only kdev_t.h knows about the actual structure of kdev_t
> > it is very easy to switch.
> > 
> 
> The main advantage with making it a struct is that it keep people from
> doing stupid stuff like (int)dev where dev is a kdev_t...  There is
> all kinds of shit like that in the kernel...

If you want that good quality 64-bit code, try making it a struct
containing just a u64 :)

-- Jamie
