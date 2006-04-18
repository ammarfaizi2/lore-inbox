Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWDRUg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWDRUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDRUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:36:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42669 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932326AbWDRUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:36:56 -0400
Date: Tue, 18 Apr 2006 15:36:53 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerrit Huizenga <gh@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@namei.org>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418203653.GJ29302@sergelap.austin.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145386009.21723.27.camel@localhost.localdomain> <20060418195956.GH29302@sergelap.austin.ibm.com> <1145391612.16632.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145391612.16632.236.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2006-04-18 at 14:59 -0500, Serge E. Hallyn wrote:
> > Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> > > On Maw, 2006-04-18 at 09:50 -0700, Gerrit Huizenga wrote:
> > > > or are there places where a "less than perfect, easy to use, good enough"
> > > > security policy?  I believe there is room for both based on the end
> > > > users' needs and desires.  But that is just my opinion.
> > > 
> > > Poor security systems lead to less security than no security because it
> > > lulls people into a false sense of security. Someone who knows their
> > 
> > Not wanting to make any digs one way or another, but because the culture
> > right now refuses to admit it I must point out:
> > 
> > So does "security" which is too complicated and therefore ends up
> > misconfigured (or disabled).
> 
> Not sure who refuses to admit it, but there is plenty of work in
> progress to improve SELinux useability.  But that doesn't require

Yes, absolutely, some very good work.

I used to think I'd want selinux protecting the TCB, but worried about
user customizations threatening the integrity of the TCB policy.  But
the namespace extension (.) may even allay that fear.

-serge
