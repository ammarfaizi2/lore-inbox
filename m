Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTENGZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTENGZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:25:47 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:37389 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S262269AbTENGZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:25:45 -0400
Date: Wed, 14 May 2003 00:38:29 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] aic7xxx build fix
Message-ID: <512652704.1052894309@aslan.scsiguy.com>
In-Reply-To: <20030513232204.4248046a.akpm@digeo.com>
References: <20030513232204.4248046a.akpm@digeo.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/scsi/aic7xxx/aic7xxx_osm.c:147: warning: `errno' defined but not used
> drivers/scsi/aic7xxx/aic79xx_osm.c:68: warning: `errno' defined but not used
> 
> and it uses -Werror.

Actually, the __KERNEL_SYSCALLS__ and unistd.h includes can go too.
The errno stuff was a leftover from when the driver used waitpid.

--
Justin

