Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbRGLBEr>; Wed, 11 Jul 2001 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267397AbRGLBEh>; Wed, 11 Jul 2001 21:04:37 -0400
Received: from mail.myrio.com ([63.109.146.2]:32239 "EHLO mailx.myrio.com")
	by vger.kernel.org with ESMTP id <S267393AbRGLBER>;
	Wed, 11 Jul 2001 21:04:17 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211C92A@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'jesse@cats-chateau.net'" <jesse@cats-chateau.net>,
        Kip Macy <kmacy@netapp.com>, Paul Jakma <paul@clubi.ie>
Cc: Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
Subject: RE: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 18:03:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesse Pollard wrote:

[why switching kernels is very hard, and...]
 
> Before you even try switching kernels, first implement a process
> checkpoint/restart. The process must be resumed after a boot 
> using the same
> kernel, with all I/O resumed. Now get it accepted into the kernel.

Hear, hear!  That would be a useful feature, maybe not network servers, 
but for pure number crunching apps it would save people having to write 
all the state saving and recovery that is needed now for long term 
computations.

For bonus points, make it work for clusters to synchronously save and
restore state for the apps running on all the nodes at once...

Torrey





