Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVA0CBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVA0CBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVAZXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:46:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:34506 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262038AbVAZTPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:15:51 -0500
Date: Wed, 26 Jan 2005 11:15:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: vgoyal@in.ibm.com, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, hari@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
 crashdumps.
Message-Id: <20050126111548.63bea034.akpm@osdl.org>
In-Reply-To: <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> There is evil intermingling and false dependency sharing between
>  the dying kernel and the crash capture kernel in this patch,

yikes!  I'll drop it from -mm while we have a rethink.
