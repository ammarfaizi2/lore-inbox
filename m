Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTENBxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTENBxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:53:15 -0400
Received: from fmr04.intel.com ([143.183.121.6]:16124 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262114AbTENBxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:53:12 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB07F4@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Shaheed R. Haque'" <srhaque@iee.org>, "'Andrew Morton'" <akpm@digeo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6 must-fix list, v2
Date: Tue, 13 May 2003 19:05:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Shaheed R. Haque [mailto:srhaque@iee.org]
> 
> Quoting Andrew Morton <akpm@digeo.com>:
> 
> > "Shaheed R. Haque" <srhaque@iee.org> wrote:
> > >
> > > - Add ability to restrict the the default CPU affinity mask so that
> > >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> >
> > Why is this useful?
> 
> Because it allows one to dedicate a CPU to a process. For example, lets
say you
> have a quad processor,and want to run joe-random stuff on CPU 0, but a
> specialised program on CPUs 1, 2, 3 that does not want to compete with
> joe-random stuff.

Real time applications can also benefit from this; if I can
get all the random stuff out of the way so that I know the
important, timing-sensitive thingie in CPU1 will always
get it, bonus points! ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
