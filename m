Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTEESaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTEESaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:30:39 -0400
Received: from [12.47.58.20] ([12.47.58.20]:62647 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261202AbTEESah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:30:37 -0400
Date: Mon, 5 May 2003 11:44:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm1
Message-Id: <20030505114444.0a22a180.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50L0.0305051826500.4098-100000@webdev.ines.ro>
References: <20030504231650.75881288.akpm@digeo.com>
	<Pine.LNX.4.50L0.0305051826500.4098-100000@webdev.ines.ro>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 18:43:03.0388 (UTC) FILETIME=[290549C0:01C31336]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Ivanov <andrei.ivanov@ines.ro> wrote:
>
> And... about the "Trying to free free IRQ12" messages and 
> 
>  12:          1          XT-PIC  acpi, i8042, i8042, i8042, i8042
> 
> should I worry ?

That's probably due to the "let i8042 share IRQs" patch.  It seems to be
harmless, but I need to look into it.
