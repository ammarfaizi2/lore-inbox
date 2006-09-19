Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751984AbWISODd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbWISODd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWISODd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:03:33 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:44729 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751984AbWISODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:03:32 -0400
Date: Tue, 19 Sep 2006 10:03:30 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [PATCH] SELinux: Fix bug in security_sid_mls_copy
In-Reply-To: <Pine.LNX.4.64.0609190945180.17323@d.namei>
Message-ID: <Pine.LNX.4.64.0609191003100.17440@d.namei>
References: <Pine.LNX.4.64.0609190945180.17323@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, James Morris wrote:

> From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> 
> The following fixes a bug where random mem is being tampered with in the 
> non-mls case; encountered by Jashua Brindle on a gentoo box.
> 
> Please apply.

Actually, don't.  It's for the net-2.6.19 tree.


-- 
James Morris
<jmorris@namei.org>
