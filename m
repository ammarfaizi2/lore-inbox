Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274896AbTGaWNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTGaWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:12:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:19900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270530AbTGaWKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:10:25 -0400
Date: Thu, 31 Jul 2003 14:58:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: paolo taraboi <paolo.taraboi@aruba.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 test1 and test2
Message-Id: <20030731145834.35ef6a4b.akpm@osdl.org>
In-Reply-To: <20030731173723.62865405.paolo.taraboi@aruba.it>
References: <20030731173723.62865405.paolo.taraboi@aruba.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paolo taraboi <paolo.taraboi@aruba.it> wrote:
>
> The tarfile did not include "linux/include/iobuf.h"

blkmtd.c s using internal APIs which do not exist any more.

Until the maintainer updates that driver, it is defunct.  He has indicated
that a rewrite to 2.6 is in progress, but that was some months ago.
