Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275827AbRJBGMD>; Tue, 2 Oct 2001 02:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275826AbRJBGLx>; Tue, 2 Oct 2001 02:11:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:17924 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275827AbRJBGLn>; Tue, 2 Oct 2001 02:11:43 -0400
Message-ID: <3BB95AAA.7C474889@zip.com.au>
Date: Mon, 01 Oct 2001 23:11:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "=?iso-8859-1?Q?Fr=E9d=E9ric?= L. W. Meunier" <0@pervalidus.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 0.9.10 for Alan's tree
In-Reply-To: <20011002030655.E249@pervalidus>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frédéric L. W. Meunier wrote:
> 
> Andrew Morton wrote:
> 
> > We prefer to test a lot before releasing, and the one time I
> > skipped that step was for 2.4.10, and it was the one which is
> > broken. Sigh.
> 
> How broken ? I ask because I'm worried since I use it. Or
> it's just the compilation problem with CONFIG_BUFFER_DEBUG
> and nothing serious ?
> 

The utilities which go direct to the block device /dev/xxx
aren't working correctly - e2fsck, tune2fs, etc.  The fs itself
is working OK.
