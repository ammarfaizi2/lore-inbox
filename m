Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTCONZ3>; Sat, 15 Mar 2003 08:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCONZ2>; Sat, 15 Mar 2003 08:25:28 -0500
Received: from tomts26.bellnexxia.net ([209.226.175.189]:64922 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261441AbTCONZ2>; Sat, 15 Mar 2003 08:25:28 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>,
       "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.64-mm7
Date: Sat, 15 Mar 2003 08:36:37 -0500
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030315112935.1841.qmail@linuxmail.org> <20030315033550.32bc34cd.akpm@digeo.com>
In-Reply-To: <20030315033550.32bc34cd.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303150836.38150.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2003 06:35 am, Andrew Morton wrote:
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
> > ----- Original Message -----
> > From: Andrew Morton <akpm@digeo.com>
> > Date: 	Sat, 15 Mar 2003 01:17:58 -0800
> > To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
> > Subject: 2.5.64-mm7
> >
> > > . Niggling bugs in the anticipatory scheduler are causing problems. 
> > > I've reset the default to elevator=deadline until we get these fixed
> > > up.
> >
> > I haven't still experienced those bugs using mm6 and AS.
>
> Me either.
>
> > Is there an easy way to reproduce them?
>
> If there was, they'd be fixed.

Actually its easy to repro at least one of them here.  Nick has
been sending me debug versions of the patch and has a debug output
from a boot here that stalls.  IMHO Latench is as big a problem
as reproducing the bug(s).

Ed Tomlinson
