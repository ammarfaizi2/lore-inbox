Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267855AbUGWRie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267855AbUGWRie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 13:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267857AbUGWRid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 13:38:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267855AbUGWRiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 13:38:25 -0400
Date: Fri, 23 Jul 2004 13:37:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Steve G <linux_4ever@yahoo.com>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: Ext3 problems in dual booting machine with SE Linux
In-Reply-To: <20040723153715.81677.qmail@web50610.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0407231333000.4446@devserv.devel.redhat.com>
References: <20040723153715.81677.qmail@web50610.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Steve G wrote:

> Something seems wrong in either 2.4.20's handling of Ext3 or 2.6.7-1.437's use of
> Ext3.

You may have hit either the 2.4/2.6 xattr compatibility bug, or some other
xattr bug since fixed in the kernel.  I'd suggest using a 2.4.25 or
greater kernel if you want to access ext2/ext3 xattrs which were created
under 2.6.  2.4 kernels below this do not have 2.6 compatible xattrs for
ext2 and ext3.


- James
-- 
James Morris
<jmorris@redhat.com>

