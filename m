Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWDYPCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWDYPCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWDYPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:02:39 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:38634 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932253AbWDYPCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:02:38 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060425124609.GA10113@thunk.org>
References: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0604250254520.15998@d.namei>
	 <20060425124609.GA10113@thunk.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 11:06:10 -0400
Message-Id: <1145977570.21399.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 08:46 -0400, Theodore Ts'o wrote:
> On Tue, Apr 25, 2006 at 03:50:00AM -0400, James Morris wrote:
> > To make a rough analogy (as Ted mentioned his IETF work earlier...): 
> > 
> > The fundamental mechanisms of IPsec are sound.  It has taken many, many 
> > years to get it to this stage, despite claims of it being "too 
> > complicated".  In that time, several "simple" protocols were designed and 
> > implemented to address the "complexity" issues, but it turns out, after 
> > all, that with the right level of abstraction and tools, IPsec is not too 
> > complicated to be secure or to use: by the obvious example of both its 
> > widespread adoption and, afaik, no systemic security failures.
> 
> And yet, many people use SSH and TLS, and it is more than sufficient
> for their needs.  Despite being very involved with the development of
> IPSec, and Kerberos, there are plenty of times when I will tell people
> to *not* use those technologies because they are *just* *too*
> *complicated*.
> 
> Choice is good.
> 
> SELinux should not be the only way to do things.

That's fine - it doesn't explain why a path-based access control
mechanism belongs in the kernel.  Or why LSM is the right way to
implement such a mechanism, given the complete mismatch in the placement
and interfaces of its hooks.

Let's keep the debate separate, please - there is one debate regarding
removal of LSM, and you've expressed your view there.  There is another
debate regarding whether AppArmor belongs in the kernel, and that
depends on the answers to the above questions.  But it isn't sufficient
to argue that because SELinux isn't the only true way that AppArmor
should be merged, eh?

-- 
Stephen Smalley
National Security Agency

