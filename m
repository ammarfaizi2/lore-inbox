Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVJ2TPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVJ2TPb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVJ2TPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:15:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932112AbVJ2TPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:15:30 -0400
Date: Sat, 29 Oct 2005 12:14:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
Message-Id: <20051029121454.5d27aecb.akpm@osdl.org>
In-Reply-To: <20051029182228.GA14495@havoc.gtf.org>
References: <20051029182228.GA14495@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Please pull from 'upstream-linus' branch of
>  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
>  to obtain misc fixes and cleanups, and to merge
>  the ATA passthru (SMART support) feature.

Are you sure this doesn't propagate Max Kellermann's "2.6.14-rc4-mm1 and
later: second ata_piix controller is invisible" regression?

He did confirm that git-libata-all.patch caused it.
