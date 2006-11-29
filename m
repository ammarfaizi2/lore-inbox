Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758840AbWK2NU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbWK2NU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbWK2NU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:20:57 -0500
Received: from bay0-omc2-s29.bay0.hotmail.com ([65.54.246.165]:33356 "EHLO
	bay0-omc2-s29.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1758840AbWK2NU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:20:56 -0500
Message-ID: <BAY107-F302D53E3CC04B6B8AEA7E29CE40@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: fs/9p/vfs_inode.c(406): remark #593: variable "sb" was set but never used    
Date: Wed, 29 Nov 2006 13:20:52 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Nov 2006 13:20:56.0157 (UTC) FILETIME=[33C1E0D0:01C713B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

1.

fs/9p/vfs_inode.c(406): remark #593: variable "sb" was set but never used

The source code is

    struct super_block *sb = NULL;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

2.

fs/9p/vfs_inode.c(757): remark #593: variable "olddirfidnum" was set but 
never used
fs/9p/vfs_inode.c(758): remark #593: variable "newdirfidnum" was set but 
never used

More of the same.

Regards

David Binderman

_________________________________________________________________
Find Singles In Your Area Now With Match.com! msnuk.match.com

