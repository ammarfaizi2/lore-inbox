Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267083AbUBFAYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267090AbUBFAYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:24:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:13505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267083AbUBFAWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:22:39 -0500
Date: Thu, 5 Feb 2004 16:23:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size
Message-Id: <20040205162355.7a4d4858.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB58024C3@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB58024C3@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew,
> 
> Will you merge the changes in the network area first while I'm working
> on the solution suggested here for inode and dentry? The 2GB tcp hash is
> the biggest problem for us right now.

Is there some reason why TCP could not also end up creating 100's of
millions of objects?

