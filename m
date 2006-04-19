Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDSR5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDSR5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWDSR5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:57:51 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:55398 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751120AbWDSR52 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:57:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PzGdV/6ztUGNPz+UuKzpWksAvSxp06TS/gUtyKHs58jhNGpobWvzXC3Ji8zOdK2KVpdzGGtvtuZiT34rCs4X1koHJyiYfuyM8Jnxt65q0Tf595Irg0AgXUXUWBk6vldRIyylW2aMWizcuLI/Px3vMHwjDvAmjcB80zeR8FSYo6Y=
Message-ID: <2e00cdfd0604191057h5d663319xab6ee62ca58fbe28@mail.gmail.com>
Date: Wed, 19 Apr 2006 12:57:26 -0500
From: "Emily Ratliff" <ejratl@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Cc: "David Safford" <safford@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       "James Morris" <jmorris@namei.org>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1145460417.24289.116.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1145458322.2377.12.camel@localhost.localdomain>
	 <1145460417.24289.116.camel@moss-spartans.epoch.ncsc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> BTW, since you point to LOMAC as evidence, can you point to an actual
> user community that uses LOMAC?
EVM & SLIM are part of IBM's internal supported Linux desktop, so
there are quite a few users.

> My concerns with low water mark were noted in
> http://marc.theaimsgroup.com/?l=linux-security-module&m=113232319627338&w=2
...
And Tim Fraser's and Dave Safford's responses are noted in
http://marc.theaimsgroup.com/?l=linux-security-module&m=113323166505015&w=2
http://marc.theaimsgroup.com/?l=linux-security-module&m=113337110408758&w=2
http://marc.theaimsgroup.com/?l=linux-security-module&m=113234278611701&w=2

> If such models can demonstrate their viability, then you can ultimately
> submit a patch to extend SELinux/Flask to support them - I have no
> problem with that (again, if they can be shown to be viable and
> implementation is correct).
Dave has an existing implementation with a user base of a formally
proven security model. He is addressing implementation concerns and
continuing to try to get SLIM accepted. Why should he be required to
extend SELinux?
