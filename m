Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbWEXPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbWEXPz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWEXPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:55:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932756AbWEXPzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:55:54 -0400
Date: Wed, 24 May 2006 08:54:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org, serue@us.ibm.com,
       herbert@13thfloor.at, dev@sw.ru, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 3/3] proc: make UTS-related sysctls utsns aware
Message-Id: <20060524085414.40b980f5.akpm@osdl.org>
In-Reply-To: <20060523012301.13531.12776.stgit@localhost.localdomain>
References: <20060523012300.13531.96685.stgit@localhost.localdomain>
	<20060523012301.13531.12776.stgit@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
>
> Add a new function proc_do_utsns_string, that derives the pointer
>  into the uts_namespace->name structure, currently based on the
>  filename of the dentry in /proc, and calls _proc_do_string()
>  ---
>  RFC only - not tested yet.  builds, though

So... is it tested yet?

You owe me three Signed-off-by:s, please.

