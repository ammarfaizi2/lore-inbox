Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbULAGxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbULAGxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULAGxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:53:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:8912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261315AbULAGx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:53:29 -0500
Date: Tue, 30 Nov 2004 22:53:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve French <smfltc@us.ibm.com>
Cc: eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol
 CIFSSMBSetPosixACL
Message-Id: <20041130225303.7abb16b8.akpm@osdl.org>
In-Reply-To: <41AD67E0.9070207@us.ibm.com>
References: <41AD67E0.9070207@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfltc@us.ibm.com> wrote:
>
>  The CIFS code has had major recent update (most importantly the 
>  cifs_readdir rewrite which can be enabled in mm by "echo 1 > 
>  /proc/fs/cifs/NewReaddirEnabled",

Nobody will do that, so the new code won't get tested.

In keeping with my evil plan to drive -mm users insane, could I ask that
you send me a diff which will make the new readdir code default to "on"?

