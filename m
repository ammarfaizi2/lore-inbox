Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTG3XMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272335AbTG3XMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:12:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11871 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S272333AbTG3XMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:12:31 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307302312.h6UNCS324747@devserv.devel.redhat.com>
Subject: Re: Warn about taskfile?
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 30 Jul 2003 19:12:28 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20030730230332.GD144@elf.ucw.cz> from "Pavel Machek" at Gor 31, 2003 01:03:32 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you explain a bit more? If multi_mode needs taskfile perhaps we
> need to kill compilation? [Attached patch probably is not enough,
> AFAICS multimode can be turned on without this config option, but it
> should be clear what I mean.]

You need taskfile to get the multiread/write cases right when you
hit stuff like errors

> If I want safest possible configuration for 2.6.0, is
> CONFIG_TASKFILE_IO=n, CONFIG_IDEDISK_MULTI_MODE=n and hdparm -c 1
> /dev/hda good idea?

NFS, read only.

