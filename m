Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUAFSU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUAFSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:20:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:12217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264929AbUAFSUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:20:24 -0500
Date: Tue, 6 Jan 2004 10:20:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jgarzik@pobox.com, linux@syskonnect.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mm2: warning in drivers/net/sk98lin/skge.c
Message-Id: <20040106102009.4e058f51.akpm@osdl.org>
In-Reply-To: <20040106181318.GH11523@fs.tum.de>
References: <20040105002056.43f423b1.akpm@osdl.org>
	<20040106181318.GH11523@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> drivers/net/sk98lin/skge.c: In function `skge_probe':
> drivers/net/sk98lin/skge.c:713: warning: unused variable `proc_root_initialized'

hm, I thought I sent Jeff a fix for that.

Yes, the definition should just be deleted.
