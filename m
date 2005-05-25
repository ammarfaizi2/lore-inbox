Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVEYTDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVEYTDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 15:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEYTDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 15:03:25 -0400
Received: from animx.eu.org ([216.98.75.249]:60325 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261531AbVEYS4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:56:55 -0400
Date: Wed, 25 May 2005 14:54:05 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: initramfs
Message-ID: <20050525185405.GC1098@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050525174135.GA1098@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525174135.GA1098@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> running cpio -tv, I see:
> ...
> -rwxr-xr-x   1 root     root       452508 May  5 14:33 bin/busybox
> ...
> -rwxr-xr-x   1 root     root         1328 May  9 15:46 init
> ...
> 
> Now I see a message saying:
> Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

My fault. I haven't used cpio much.  The cpio archive contained only files,
no directories, thus there was no /bin to put /bin/busybox in.  I now have
it working.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
