Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWBOLxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWBOLxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWBOLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:53:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751062AbWBOLxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:53:10 -0500
Date: Wed, 15 Feb 2006 03:52:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Rustad <MRustad@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] elf: 0-length loading issue
Message-Id: <20060215035205.13f637bc.akpm@osdl.org>
In-Reply-To: <r02010500-1044-527BBEA29DD111DA99F10011248907EC@[192.168.1.21]>
References: <r02010500-1044-527BBEA29DD111DA99F10011248907EC@[192.168.1.21]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad <MRustad@mac.com> wrote:
>
> I have run into an elf loading issue when moving a program from running with a 2.6.5-
>  derived SuSE kernel to the 2.6.15 kernel.org kernel. The image being loaded is admittedly
>  unusual, but used to work and seems to me to be valid.

This was fixed in 2.6.16-rc1.  I'll send that fix over to the 2.6.15.x
maintainers, thanks.

