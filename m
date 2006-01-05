Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWAEDvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWAEDvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWAEDvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:51:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751131AbWAEDvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:51:12 -0500
Date: Wed, 4 Jan 2006 19:50:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
Subject: Re: [PATCH 0/20] inflate: refactor boot-time inflate code
Message-Id: <20060104195057.75ab3fe1.akpm@osdl.org>
In-Reply-To: <1.150843412@selenic.com>
References: <1.150843412@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> This is a refactored version of the lib/inflate.c:

allnoconfig fails:

lib/lib.a(inflate.o)(.text+0x1f): In function `flush_output':
: undefined reference to `crc32_le'

