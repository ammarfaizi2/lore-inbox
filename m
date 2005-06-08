Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVFHUCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFHUCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVFHUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:02:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:22698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbVFHUBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:01:55 -0400
Date: Wed, 8 Jun 2005 13:01:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: pazke@donpac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-Id: <20050608130117.341fa4ff.akpm@osdl.org>
In-Reply-To: <42A6FF41.5040109@shadowen.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<42A6FF41.5040109@shadowen.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> We've been seeing an early boot hang on IBM x-series (at least on an
>  x440) with -rc6-mm1.  Finally got hold of a box to go search for this
>  and it seems that backing out the three patches below fixes it.
> 
>   515  dmi-move-acpi-boot-quirk.patch
>   516  dmi-move-acpi-sleep-quirk.patch
>   517  dmi-remove-central-blacklist.patch

Thanks for taking the time to do that - it helps enormously.

The patches aren't terribly important - I'll drop them if nobody sees the
problem.  It might be an incorrect __init/__initdata/etc marking.  But that
wouldn't cause an "early" boot hang...


