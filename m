Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUBXSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUBXS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:29:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54912 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262396AbUBXS2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:28:16 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Date: Tue, 24 Feb 2004 13:26:04 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <20040216190927.GA2969@us.ibm.com> <200402211409.13203.phillips@arcor.de> <20040222103731.GA19437@marowsky-bree.de>
In-Reply-To: <20040222103731.GA19437@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402241326.05698.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 February 2004 05:37, Lars Marowsky-Bree wrote:
> > > So, how does OpenGFS/GFS achieve the communication? How does it
> > > interact with the infrastructure (which, I infere from your above
> > > comments, is meant to reside in user-space)?
> >
> > It's done both ways, actually.  No new kernel hooks are used in either
> > case.
>
> That doesn't answer my question how you are doing the user-space /
> kernel communication ;-)

Hi Lars,

OpenGFS uses sockets, see:

http://cvs.sourceforge.net/viewcvs.py/opengfs/opengfs/src/locking/modules/memexp/moduleops.c?view=markup

> And will the user-space infrastructure to go with GFS be open source
> too? Questions over questions.

Yes, it's all to be opened up.  If you don't mind, I'd prefer to hold off 
discussing the infrastructure details until the code lands.

Regards,

Daniel

