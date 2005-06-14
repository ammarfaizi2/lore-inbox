Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVFNUpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVFNUpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFNUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:45:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbVFNUpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:45:40 -0400
Date: Tue, 14 Jun 2005 13:45:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: Re: [patch 1/2] pcspeaker driver update
Message-Id: <20050614134518.68df565d.akpm@osdl.org>
In-Reply-To: <42AF2454.8090806@aknet.ru>
References: <42AF2454.8090806@aknet.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Attached one is just a clean-up:
>  it removes the extern definitions
>  for the i8253_lock and i8259A_lock,
>  making the use of the appropriate
>  headers instead.

A nice cleanup to make, however we cannot include asm/timer.h from generic
code, because only a few architectures have such a file.

