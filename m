Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUABRLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbUABRLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:11:14 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:3210
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265613AbUABRLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:11:13 -0500
Subject: Re: >>>reg writing kernel modules to resolve stale file handle
	error in nfs environment<<<<
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Srinivasan Ramaswamy <ursvasan@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040102163921.59255.qmail@web8105.in.yahoo.com>
References: <20040102163921.59255.qmail@web8105.in.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073063472.1855.22.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 12:11:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 02/01/2004 klokka 11:39, skreiv Srinivasan Ramaswamy:
> sir
> my qestion is regarding resolving stale file handle
> error in an nfs environment.i want to resolve it using
> some RPC's and some kernel modules.my question is
> 
> >>>>>can we resolve the stale file handle error by
> using Devfs and create a layer of insulation<<<<<<

Huh?

Stale file handles are a result of user error (i.e. deleting a file on
the server while it is still in use on another NFS client). The only way
to "resolve" them is by application of a carefully designed end-user
education program that teaches how not to ssh to another machine and
then do "rm" on the file that is being edited.

Cheers,
  Trond
