Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317718AbSGKCY7>; Wed, 10 Jul 2002 22:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317720AbSGKCY6>; Wed, 10 Jul 2002 22:24:58 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55302 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317718AbSGKCY4>; Wed, 10 Jul 2002 22:24:56 -0400
Date: Thu, 11 Jul 2002 04:27:38 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Steven Cole <elenstev@mesatop.com>,
       Vitaly Fertman <vitaly@namesys.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: reiserfsprogs release
Message-ID: <20020711022738.GD1384@merlin.emma.line.org>
Mail-Followup-To: reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Steven Cole <elenstev@mesatop.com>,
	Vitaly Fertman <vitaly@namesys.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> <200207101206.48370.vitaly@namesys.com> <1026311034.7074.76.camel@spc9.esa.lanl.gov> <20020710153801.A8570@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710153801.A8570@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Christoph Hellwig wrote:

> On Wed, Jul 10, 2002 at 08:23:54AM -0600, Steven Cole wrote:
> > On Wed, 2002-07-10 at 02:06, Vitaly Fertman wrote:
> > > 
> > > Hi all,
> > > 
> > > the latest reiserfsprogs-3.6.2 is available on our ftp site.
> > > 
> > 
> > Is the following patch to Documentation/Changes appropriate?
> 
> Does reiserfs in 2.4.19-pre require that version?  if yes it would be
> very bad (2.4 is not supposed to need newer userlevel during the series)

Well, there's user-space and user-space. A part of the user space is
kernel/system oriented, like fsck.* or util-linux (mount, chattr!)
configuration tools or user-space parts of drivers, and there's a part
of user-space that is unrelated.

If the kernel related stuff (which usually is in /sbin) needs to be
updated, that's fine even for a "stable" kernel. If the new
reiserfs-progs fix a problem of an older version, then by all means go
fix and update Documentation/Changes. There could be a new "recommended"
column though which lists non-critical version updates.

-- 
Matthias Andree
