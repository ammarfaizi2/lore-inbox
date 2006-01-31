Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWAaXlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWAaXlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWAaXlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:41:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932164AbWAaXlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:41:04 -0500
Date: Tue, 31 Jan 2006 15:42:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] disable lost tick compensation before TSCs are synced
Message-Id: <20060131154258.2aa5634c.akpm@osdl.org>
In-Reply-To: <1138660164.10057.20.camel@cog.beaverton.ibm.com>
References: <1138660164.10057.20.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> The new timekeeping work avoids this issue, but since it is not quite
> ready for mainline, this patch would be a good idea for 2.6.16.

Oh.  That simplifies things.
