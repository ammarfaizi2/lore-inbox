Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUEMTvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUEMTvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUEMTgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:36:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:51906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264506AbUEMTWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:22:10 -0400
Date: Thu, 13 May 2004 12:21:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-Id: <20040513122142.229cc846.akpm@osdl.org>
In-Reply-To: <39780000.1084475697@flay>
References: <39780000.1084475697@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 2.6.6-mm2 won't compile without CONFIG_MODULE_UNLOAD ... looks very much
> like the first definition of add_attribute needs moving inside the ifdef.
> 
> kernel/module.c:730: redefinition of `add_attribute'
> kernel/module.c:382: `add_attribute' previously defined here

Yup, sorry.  Please revert bk-driver-core-module-fix.patch
