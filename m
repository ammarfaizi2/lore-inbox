Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUCOMqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbUCOMqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:46:30 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:8712 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262551AbUCOMq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:46:28 -0500
Date: Mon, 15 Mar 2004 20:47:05 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
       mszeredi@inf.bme.hu, herbert@13thfloor.at
Subject: Re: unionfs
In-Reply-To: <20040315121934.GB16615@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0403152045290.14862@raven.themaw.net>
References: <200403151235.25877.cotte@freenet.de> <20040315121934.GB16615@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, [iso-8859-1] Jörn Engel wrote:

> On Mon, 15 March 2004 12:35:25 +0100, Carsten Otte wrote:
> > Herbert Poetzl wrote:
> > >FWIW, have a look at http://vserver.13thfloor.at/TBVFS
> > I do really think this problem needs to be solved a different way: BSD-style 
> > union mount in VFS, no redirecting filesystem.
> > I am planning to work on that during the 2.7. series. I do hope I will be able 
> > to write code clean enough for inclusion, lets see...
> 
> You could also have some sort of 'hidden symlink', i.e. something that
> behaves just like a file but is in fact a link to some other
> filesystem.  If that other filesystem is not accessable, all
> operations return -EIO.

Sounds a bit untidy.

Has anyone checked http://www.filesystems.org/

What do you think?

Ian

