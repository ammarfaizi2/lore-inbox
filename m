Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTGCBib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 21:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTGCBia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 21:38:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30224 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264479AbTGCBi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 21:38:29 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PTY DOS vulnerability?
Date: 2 Jul 2003 18:52:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <be028l$q69$1@cesium.transmeta.com>
References: <200306301613.11711.fredrik@dolda2000.cjb.net> <03070106574900.01125@tabby> <20030701195323.GA15483@hh.idb.hist.no> <03070220143600.04348@tabby>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <03070220143600.04348@tabby>
By author:    Jesse Pollard <jesse@cats-chateau.net>
In newsgroup: linux.dev.kernel
> >
> > Isn't this something a improved sshd could do?  I.e. if the
> > connection using up the last (or one of the last) pty's logs
> > in as non-root - just kill it.
> 
> and how is it to determine that it is the last?
> try two and die if the second fails???
> at least one system just creates more ptys...
> 

Viro's working on it... but as someone else pointed out,
"ssh root@machine bash -i" works great without any ptys.  You don't
have all features, but enough to nuke whatever it is that's eating
them all.

     -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
