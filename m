Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUGTRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUGTRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUGTRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:46:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57008 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266063AbUGTRqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:46:23 -0400
Date: Tue, 20 Jul 2004 13:45:43 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Danny ter Haar <dth@ncc1701.cistron.net>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.8-rc2-bk1: selinux won't compile
In-Reply-To: <cdiinu$ous$1@news.cistron.nl>
Message-ID: <Pine.LNX.4.58.0407201345290.23516@devserv.devel.redhat.com>
References: <cdiinu$ous$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004, Danny ter Haar wrote:

> security/selinux/hooks.c: In function `selinux_bprm_apply_creds':
> security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared (first use in this functio
> security/selinux/hooks.c:1898: error: (Each undeclared identifier is reported only once
> security/selinux/hooks.c:1898: error: for each function it appears in.)

Use this patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109015367031947&w=2

- James
-- 
James Morris
<jmorris@redhat.com>

