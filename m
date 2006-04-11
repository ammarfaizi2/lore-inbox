Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDKWFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDKWFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDKWFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:05:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751136AbWDKWFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:05:16 -0400
Date: Tue, 11 Apr 2006 15:07:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org, rmy@tigress.co.uk
Subject: Re: [patch 1/1] selinux: Fix MLS compatibility off-by-one bug
Message-Id: <20060411150737.3baf664a.akpm@osdl.org>
In-Reply-To: <1144774386.20422.60.camel@moss-spartans.epoch.ncsc.mil>
References: <1144774386.20422.60.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> This patch fixes an off-by-one error in the MLS compatibility code
> that was causing contexts with a MLS suffix to be rejected, preventing
> sharing partitions between FC4 and FC5.  Bug reported in  
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188068
> Please apply, for 2.6.17 if possible.

Is this appropriate to 2.6.16.x?
