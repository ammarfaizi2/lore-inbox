Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVDCJgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDCJgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDCJgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:36:44 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:52935 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261627AbVDCJgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:36:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gHGuEkNeA+76b0ya62Z/Y3WFtXPFazxQAdmySc6p9ai3yjShQ/Zb2uBRG2Lj2WSk3WPkRW9+tvgCntDIwCQJEDpCB4yHJIrbOOjRzV5PagbR2oKciOREpGzwIgWQP2mXrn7TysSHk2rUvNph5FVhiUZrqCrn5UPxBmfi1w/YsNI=
Message-ID: <21d7e99705040301366b1064b6@mail.gmail.com>
Date: Sun, 3 Apr 2005 19:36:42 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] Add name_connect permission check
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <1111588875.21107.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1111588807.21107.68.camel@moss-spartans.epoch.ncsc.mil>
	 <1111588875.21107.69.camel@moss-spartans.epoch.ncsc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2005 12:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2005-03-23 at 09:40 -0500, Stephen Smalley wrote:
> > This patch adds a name_connect permission check to SELinux to provide
> > control over outbound TCP connections to particular ports distinct
> > from the general controls over sending and receiving packets.  Please
> > apply.
> >

On a standard FC3 with selinux enabled, booting the latest -bk breaks
all my outgoing TCP connections at a guess due to this patch.. this
probably isn't something that people really want to happen.. or maybe
Fedora can release an updated policy to deal with it?

Dave.
