Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWDZSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDZSEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWDZSEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:04:38 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13441 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932329AbWDZSEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:04:37 -0400
Date: Wed, 26 Apr 2006 11:04:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LSM: add missing hook to do_compat_readv_writev()
Message-ID: <20060426180411.GF3107@sorel.sous-sol.org>
References: <Pine.LNX.4.64.0604260237260.26341@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604260237260.26341@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> This patch addresses a flaw in LSM, where there is no mediation of readv() 
> and writev() in for 32-bit compatible apps using a 64-bit kernel.
> 
> This bug was discovered and fixed initially in the native readv/writev 
> code [1], but was not fixed in the compat code.  Thanks to Al for spotting 
> this one.
> 
> 
> Please apply.
> 
> Signed-off-by: James Morris <jmorris@namei.org> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Chris Wright <chrisw@sous-sol.org>

thanks,
-chris
