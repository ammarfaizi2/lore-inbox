Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTLPNoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTLPNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:44:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261779AbTLPNoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:44:08 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3FDD7DFD.7020306@labs.fujitsu.com>
References: <3FDD7DFD.7020306@labs.fujitsu.com>
Content-Type: text/plain
Organization: 
Message-Id: <1071582242.5462.1.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Dec 2003 13:44:02 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-12-15 at 09:25, Tsuchiya Yoshihiro wrote:

> Following is an Ext2 result and the inode is filled by zero.
> I think the inode becomes a badinode.

> [root@dell04 tsuchiya]# ls -l /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html
> ls: /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html: Input/output error

"Input/output error" can sometimes mean that the kernel has found a
filesystem problem, but it also often indicates a device-layer problem. 
Is there anything helpful in the kernel logs?

Cheers,
 Stephen


