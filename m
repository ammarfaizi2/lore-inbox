Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCaP4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCaP4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCaP4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:56:32 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12759 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261517AbVCaP4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:56:19 -0500
Message-Id: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files 
In-Reply-To: Message from =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com> 
   of "Wed, 30 Mar 2005 18:55:24 +0200." <yw1xpsxhvzsz.fsf@ford.inprovide.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 31 Mar 2005 11:56:09 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 31 Mar 2005 11:56:10 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com> said:
> Wiktor <victorjan@poczta.onet.pl> writes:

[...]

> > max renice ulimit is quite good idea, but it allows to change nice of
> > *any* process user has permissions to. it could be implemented also,
> > but the idea of 'nice' file attribute is to allow *only* some process
> > be run with lower nice. what's more, that nice would be *always* the
> > same (at process startup)!

> It can be done entirely in userspace, if you want it.  Just hack your
> shell to examine some extended attribute of your choice, and adjust
> the nice value before executing files.  Then arrange to have the shell
> run with a negative nice value.  This can be easily accomplished with
> a simple wrapper, only for the shell.

Even better: Write a C wrapper for each affected program that just renices
it as needed.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
