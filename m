Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWDQT6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDQT6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDQT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:58:20 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:45724 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750830AbWDQT6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:58:19 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Safford <safford@watson.ibm.com>
In-Reply-To: <20060417194759.GD18990@sergelap.austin.ibm.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 17 Apr 2006 16:02:26 -0400
Message-Id: <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 14:47 -0500, Serge E. Hallyn wrote:
> Quoting James Morris (jmorris@namei.org):
> > Last I recall on this issue, we asked if you could look at providing 
> > integrity measurement as a distinct API, and integrity control as either 
> > integrated with SELinux or a distinct component which SELinux could use.
> 
> And those are what I believe the next patchset will provide.

At the conclusion of the last round of discussions on slim-evm-ima on
list, it was the case that:
- ima was no longer an issue, as it had already ceased being a separate
LSM,
- it was demonstrated that evm needed to be tightly coupled with any LSM
in order to work correctly and efficiently, and it seemed to be accepted
that evm needed to be turned from a separate LSM into a set of support
functions for use by a LSM (as well as having many other design and
implementation problems to resolve to be truly useable),
- it was argued that slim was broken-by-design and no one was willing or
able to refute that position.

Hardly a strong case for LSM...

-- 
Stephen Smalley
National Security Agency

