Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJENHq>; Sat, 5 Oct 2002 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSJENHq>; Sat, 5 Oct 2002 09:07:46 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:42235 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262325AbSJENHp>; Sat, 5 Oct 2002 09:07:45 -0400
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20021005071003.A15345@wotan.suse.de>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.
	 suse.lists.linux.kernel> <p73adltqz9g.fsf@oldwotan.suse.de>
	<3D9E72C8.1070203@pobox.com>  <20021005071003.A15345@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 14:21:55 +0100
Message-Id: <1033824115.3425.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 06:10, Andi Kleen wrote:
> > * viro might have a cow at the use of kdev_t_to_nr...  is that required 
> > for compatibility with some existing apps?  It seems like you want to 
> > _decompose_ a number into major/minor, to be an interface that 
> > withstands the test of time
> 
> It withstands the test of time as well as stat(2) or the loop ioctls.

Is that old stat, stat, stat64 or the proposed new stat64 ?

I see no good reason for this ioctl at all, in any tree.

