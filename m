Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDRX2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDRX2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDRX2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:28:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47745 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750788AbWDRX2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:28:42 -0400
Date: Tue, 18 Apr 2006 16:27:43 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Crispin Cowan <crispin@novell.com>
Cc: James Morris <jmorris@namei.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418232743.GA3077@sorel.sous-sol.org>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com> <44453E7B.1090009@novell.com> <1145391969.21723.41.camel@localhost.localdomain> <444552A7.2020606@novell.com> <Pine.LNX.4.64.0604181709160.28128@d.namei> <4445719E.8020300@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4445719E.8020300@novell.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Crispin Cowan (crispin@novell.com) wrote:
> However, I assert (emphatically :) that the broader user community has
> integrity and availability as higher priorities than secrecy, and that
> pathname-based access control is a better way to achieve that. I want to
> offer Linux users the choice of pathname-based access control if they
> want it. Why do you want to prevent them from having that choice?

I'm in favor of choice.  And it's no doubt that users appreciate the
intuitiveness of pathname based security.  The real question is the
actual security of the system.  What we don't want is a choice that
embodies any false sense of security.  So that is why it's important to
understand how AppArmor protects from the pathname based attacks.

thanks,
-chris
