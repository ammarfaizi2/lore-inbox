Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWGLJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWGLJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWGLJ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:26:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbWGLJ0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:26:02 -0400
Date: Wed, 12 Jul 2006 02:26:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Message-Id: <20060712022600.2a474257.akpm@osdl.org>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27043F5D1C@uk-email.terastack.bluearc.com>
References: <89E85E0168AD994693B574C80EDB9C27043F5D1C@uk-email.terastack.bluearc.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 08:58:52 +0100
"Andy Chittenden" <AChittenden@bluearc.com> wrote:

> I tried to install the linux-image-2.6.17-1-amd64-k8-smp debian package
> on a ASUS M2NPV-VM motherboard based system and it hung during boot. The
> last message on the console was:
> 
>  io scheduler cfq registered

Suggest you add initcall_debug to the kernel boot command line.  That'll
tell us which initcall got stuck.

