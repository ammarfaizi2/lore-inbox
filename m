Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUHEHc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUHEHc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267593AbUHEHcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:32:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:23479 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267592AbUHEHcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:32:47 -0400
Date: Thu, 5 Aug 2004 00:31:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-Id: <20040805003112.1d54ed8e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408042216.12215.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> (Andrew - I think you should drop that patch, or at least enable 
>  BUGVERBOSE on x86 - it looks like it's disabled and with no way to enable 
>  it in the current -mm tree..)

ah, OK.  I'll put it back to `#if 1', thanks.
