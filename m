Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVHHOUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVHHOUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVHHOUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:20:19 -0400
Received: from [81.2.110.250] ([81.2.110.250]:55695 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932079AbVHHOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:20:17 -0400
Subject: Re: [PATCH 1/2] New system call, unshare
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Janak Desai <janak@us.ibm.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sds@tycho.nsa.gov,
       linuxram@us.ibm.com, ericvh@gmail.com, dwalsh@redhat.com,
       jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org, gh@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.WNT.4.63.0508080928480.3668@IBM-AIP3070F3AM>
References: <Pine.WNT.4.63.0508080928480.3668@IBM-AIP3070F3AM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Aug 2005 15:46:06 +0100
Message-Id: <1123512366.31229.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-08 at 09:33 -0400, Janak Desai wrote:
> 
> [PATCH 1/2] unshare system call: System Call handler function sys_unshare


Given the complexity of the kernel code involved and the obscurity of
the functionality why not just do another clone() in userspace to
unshare the things you want to unshare and then _exit the parent ?

