Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266105AbUFPDlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUFPDlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbUFPDlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:41:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266105AbUFPDlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:41:18 -0400
Date: Tue, 15 Jun 2004 23:40:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>, <selinux@tycho.nsa.gov>
Subject: Re: [SELINUX][PATCH 1/4] Fine-grained Netlink support - SELinux
 headers update
In-Reply-To: <40CFBD04.8030601@pobox.com>
Message-ID: <Xine.LNX.4.44.0406152334380.30782-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004, Jeff Garzik wrote:

> James Morris wrote:
> > This patch regenerates the SELinux module headers to reflect new class
> > and access vectors definitions.  The size of the diff is misleading;
> > much of it is simply a change in the ordering of the automatically
> > generated definitions. The corresponding generation script has been
> > changed to ensure a stable order in the future.  Please apply.
> 
> 
> Why not commit the generation script, and kill the auto-generated files?

The script lives in the SELinux policy compilation package, which is
considered the source of truth for these headers.  They are only ever
regenerated manually when significant changes are made to SELinux (like
this), and I don't think there is any advantage in doing this in the
kernel tree.


- James
-- 
James Morris
<jmorris@redhat.com>


