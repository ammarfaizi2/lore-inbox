Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJRXGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTJRXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:06:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:24240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261893AbTJRXGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:06:07 -0400
Date: Sat, 18 Oct 2003 16:06:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olivier NICOLAS <olivn@trollprod.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: 2.6.0-test8: panic on boot
Message-Id: <20031018160631.40bcf210.akpm@osdl.org>
In-Reply-To: <3F91998E.8030802@trollprod.org>
References: <3F917EFC.7020102@trollprod.org>
	<20031018112217.19841708.akpm@osdl.org>
	<3F91998E.8030802@trollprod.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier NICOLAS <olivn@trollprod.org> wrote:
>
> Thanks
> 
> 
> It works for 2.6.0-test8 with ACPI debug
> 

Fine, thanks.

> dsopcode-0526 [19] ds_init_buffer_field  : Field [C00C] size 1184 
> exceeds Buffer [<NUL] size 1088 (bits)

It is the second pointer which is null.

(The "<NULL>" was truncated because it is a "%4s".  hmm..)
