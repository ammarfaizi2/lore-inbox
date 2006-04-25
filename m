Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWDYSo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWDYSo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDYSo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:44:29 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:17856 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751058AbWDYSo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:44:27 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: "Theodore Ts'o" <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <200604251834.k3PIYTS9006648@turing-police.cc.vt.edu>
References: <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <20060424070324.GA14720@thunk.org>
	 <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20060424235215.GA5893@thunk.org>
	 <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil>
	 <200604251834.k3PIYTS9006648@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 14:48:46 -0400
Message-Id: <1145990926.21399.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 14:34 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 25 Apr 2006 12:45:33 EDT, Stephen Smalley said:
> 
> > pam_namespace in Fedora Core.  Not to mention that the restrictions you
> > mention only solve the problem within the jail, which is fine if we are
> > only talking about jail mechanisms.  Not so good for any kind of real
> > MAC.
> 
> Umm.. Stephen? Where in Fedora Core is it?  I'm running a Fedora Core Rawhide
> right now, and it's not on my system, and 'yum provides pam_namespace.so'
> doesn't find it either.  There *is* stuff over in the -lspp branch, but it
> (AFAIK) hasn't escaped into anything resembling general availability.  Was this
> what you were referencing?

Today's rawhide.  0.99.3.0-3.  ChangeLog is:
* Tue Apr 25 2006 Tomas Mraz <tmraz@redhat.com> 0.99.3.0-3
- added pam_namespace module written by Janak Desai (per-user /tmp
support)
- new pam-redhat modules version

-- 
Stephen Smalley
National Security Agency

