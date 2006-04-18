Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWDRUQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWDRUQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWDRUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:16:17 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:11262 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932316AbWDRUQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:16:16 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060418195956.GH29302@sergelap.austin.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145386009.21723.27.camel@localhost.localdomain>
	 <20060418195956.GH29302@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 18 Apr 2006 16:20:11 -0400
Message-Id: <1145391612.16632.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 14:59 -0500, Serge E. Hallyn wrote:
> Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> > On Maw, 2006-04-18 at 09:50 -0700, Gerrit Huizenga wrote:
> > > or are there places where a "less than perfect, easy to use, good enough"
> > > security policy?  I believe there is room for both based on the end
> > > users' needs and desires.  But that is just my opinion.
> > 
> > Poor security systems lead to less security than no security because it
> > lulls people into a false sense of security. Someone who knows their
> 
> Not wanting to make any digs one way or another, but because the culture
> right now refuses to admit it I must point out:
> 
> So does "security" which is too complicated and therefore ends up
> misconfigured (or disabled).

Not sure who refuses to admit it, but there is plenty of work in
progress to improve SELinux useability.  But that doesn't require
crippling the kernel mechanism, nor would that help.  Keep in mind as
well that SELinux "complexity" is purely a reflection of complexity in
Linux; SELinux just exposes the existing interactions and provides a way
to control them.  The SELinux mechanism itself is fairly simple.  

> The posix caps sendmail fiasco is one example.


-- 
Stephen Smalley
National Security Agency

