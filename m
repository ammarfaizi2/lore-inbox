Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVBXJNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVBXJNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBXJNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:13:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:8337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbVBXJNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:13:36 -0500
Date: Thu, 24 Feb 2005 01:13:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com, haveblue@us.ibm.com
Subject: Re: [PATCH] Fix for broken kexec on panic
Message-Id: <20050224011312.29668947.akpm@osdl.org>
In-Reply-To: <1109236432.5148.192.camel@terminator.in.ibm.com>
References: <1109236432.5148.192.camel@terminator.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
>  re-organization of boot memory allocator initialization code.

OK...

Where are we up to with these patches, btw?  Do you consider them
close-to-complete?  Do you have a feel for what proportion of machines will
work correctly?
