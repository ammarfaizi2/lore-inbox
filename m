Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVCWOtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVCWOtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCWOtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:49:15 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:3308 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262552AbVCWOtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:49:09 -0500
Subject: Re: [PATCH][SELINUX] Add name_connect permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111588807.21107.68.camel@moss-spartans.epoch.ncsc.mil>
References: <1111588807.21107.68.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 23 Mar 2005 09:41:15 -0500
Message-Id: <1111588875.21107.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 09:40 -0500, Stephen Smalley wrote:
> This patch adds a name_connect permission check to SELinux to provide
> control over outbound TCP connections to particular ports distinct
> from the general controls over sending and receiving packets.  Please
> apply.
> 
>  security/selinux/hooks.c                     |   48 ++++++++++++++++++++++++++-
>  security/selinux/include/av_perm_to_string.h |    1 
>  security/selinux/include/av_permissions.h    |    1 
>  3 files changed, 49 insertions(+), 1 deletion(-)

Ah, sorry - forgot the Signed-off-by lines.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

