Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVCHAVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVCHAVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCHASe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:18:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:54197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261854AbVCHAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:14:33 -0500
Date: Mon, 7 Mar 2005 16:14:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: jmorris@redhat.com, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][LSM/SELINUX] Pass requested protection to
 security_file_mmap/mprotect hooks
Message-Id: <20050307161425.746e8005.akpm@osdl.org>
In-Reply-To: <1110220105.2778.24.camel@moss-spartans.epoch.ncsc.mil>
References: <1110220105.2778.24.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> +__setup("checkreqprot=", checkreqprot_setup);

Can we have an update to Documentation/kernel-parameters.txt, please?
