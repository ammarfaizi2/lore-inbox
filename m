Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUEDXzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUEDXzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUEDXzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:55:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:24728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261706AbUEDXzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:55:54 -0400
Date: Tue, 4 May 2004 16:58:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: <yiding_wang@agilent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 scsi host reset success but all device are offlined
Message-Id: <20040504165825.7b5aa810.akpm@osdl.org>
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A8131@wcosmb01.cos.agilent.com>
References: <0A78D025ACD7C24F84BD52449D8505A15A8131@wcosmb01.cos.agilent.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<yiding_wang@agilent.com> wrote:
>
> I am running 2.6.2 linux on i386. During the error injection test,
> eh_device_reset, eh_bus_reset and eh_host_reset were called by scsi_error.c
> in sequence.  For each reset, HBA driver returned SUCCESS (0x2002, I
> specially traced the host reset case).

2.6.2 is ancient.  Please:

- test a current kernel

- ensure that linux-scsi@vger.kernel.org is copied on reports

- make the test tools available to other scsi developers

- Hit ENTER after the 70th column when typing emails ;)

Thanks.
