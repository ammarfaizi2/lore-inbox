Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbTGOQHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268845AbTGOQFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:05:01 -0400
Received: from sophia.inria.fr ([138.96.64.20]:40099 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S268827AbTGOQEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:04:15 -0400
Subject: Re: am-utils or kernel bug ? Seems to be kernel  bug.. Any news ?
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org, amd-dev@cs.columbia.edu
In-Reply-To: <87isq3uabz.fsf@ceramic.fifi.org>
References: <1058258041.19183.18.camel@atlas.inria.fr>
	 <87isq3uabz.fsf@ceramic.fifi.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: INRIA
Message-Id: <1058285921.19183.63.camel@atlas.inria.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 15 Jul 2003 18:18:41 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 16:35, Philippe Troin wrote:
> Nicolas Turro <Nicolas.Turro@sophia.inria.fr> writes:
> 
> > Hi, i posted a bug about amd hanging at boot time a few week ago,
> > does anybody has a fix for it ?
> > The bug is described here :
> > 
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=90902
> > 
> > it seems that several groups of users besides me encounter the same
> > bug....
> > 
> > If not, i'll have to post-install a 2.4.18 kernel on all my new
> > RH9 boxes :-(
> 
> Looks like YAFP (Yet Another Futex Problem).
> 
> Have you tried running with LD_ASSUME_KERNEL=2.2.5 ?
> 
> Phil.

You are right, setting LD_ASSUME_KERNEL=2.2.5 (or
LD_ASSUME_KERNEL=2.4.1) corrects the problem.
Do you have more info on this ´bug'  ?

-- 
Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
INRIA

