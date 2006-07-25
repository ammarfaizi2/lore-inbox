Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWGYEdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWGYEdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGYEdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:33:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932435AbWGYEdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:33:42 -0400
Date: Mon, 24 Jul 2006 21:33:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: torvalds@osdl.org, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add force of use MMCONFIG [try #1]
Message-Id: <20060724213339.2646435c.akpm@osdl.org>
In-Reply-To: <44BA0025.6020105@ed-soft.at>
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
	<44B6BF2F.6030401@ed-soft.at>
	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
	<44B73791.9080601@ed-soft.at>
	<Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
	<44BA0025.6020105@ed-soft.at>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006 11:00:21 +0200
Edgar Hucek <hostmaster@ed-soft.at> wrote:

> This Patch add force for mmconfig.
> On Intel Macs the efi firmaware gives
> a different memory map then ACPI_MCFG
> provides. This makes the chack wether
> to use mmconfig or not fail.

Why do we want to do this?  Are the ACPI-provided tables incorrect?  If so,
what problems are caused by this?

