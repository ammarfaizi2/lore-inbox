Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDRVg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDRVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDRVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:36:56 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:14256 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750708AbWDRVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:36:55 -0400
Date: Tue, 18 Apr 2006 17:36:50 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Crispin Cowan <crispin@novell.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <444552A7.2020606@novell.com>
Message-ID: <Pine.LNX.4.64.0604181709160.28128@d.namei>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> 
 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>  <44453E7B.1090009@novell.com>
 <1145391969.21723.41.camel@localhost.localdomain> <444552A7.2020606@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, Crispin Cowan wrote:

> SELinux has NSA legacy, and that is reflected in their inode design: it
> is much better at protecting secrecy, which is the NSA's historic
> mission.

No.  The inode design is simply correct.

Consider the following:

What if Unix DAC security was implemented via pathnames, using a 
configuration file and regexp matching enginer in the kernel, invoked 
during file access, rather than the existing scheme of checking inode 
ownership and permission attributes?

SELinux labels objects directly because it's the right thing to do.

To also clarify: the legacy of SELinux is in the decades of research 
performed into providing more comprehensive security than the original 
secrecy-oriented TCSEC schemes.  And conflating a highly loaded term such 
as "NSA's historic mission" with an implementation specific aspect of 
SELinux is useless in a technical discussion and IMHO totally 
inappropriate.



- James
-- 
James Morris
<jmorris@namei.org>

