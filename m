Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWFND7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWFND7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWFND7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:59:18 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:195 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751184AbWFND7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:59:17 -0400
Date: Tue, 13 Jun 2006 23:59:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 3/4] Core aio changes to support vectored AIO
In-Reply-To: <1150241734.7369.0.camel@dyn9047017100.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606132354580.8414@d.namei>
References: <1150241520.28414.59.camel@dyn9047017100.beaverton.ibm.com>
 <1150241734.7369.0.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Badari Pulavarty wrote:

> This work is initially done by Zach Brown to add support for
> vectored aio. These are the core changes for AIO to support
> IOCB_CMD_PREADV/IOCB_CMD_PWRITEV. 

The LSM hooksfor this look ok to me.  Certainly worth some SELinux testing 
while in -mm.


Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
