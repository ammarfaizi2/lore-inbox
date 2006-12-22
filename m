Return-Path: <linux-kernel-owner+w=401wt.eu-S1751336AbWLVR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWLVR0g (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWLVR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:26:36 -0500
Received: from xenotime.net ([66.160.160.81]:48658 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbWLVR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:26:35 -0500
Date: Fri, 22 Dec 2006 09:27:52 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rename FIELD_SIZEOF to MEMBER_SIZE and use in source
 tree.
Message-Id: <20061222092752.76af799b.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
References: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 10:34:09 -0500 (EST) Robert P. J. Day wrote:

> 
>   Rename the macro FIELD_SIZEOF() in include/linux/kernel.h to
> MEMBER_SIZE(), and make a number of replacements in the source tree
> where that macro simplified the code.

Hi,

Your CodingStyle ch. 17 additions also need to be updated
if/when they are merged (since they refer to FIELD_SIZEOF()).
Did Andrew add that to -mm?  I don't recall.

---
~Randy
