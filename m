Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUFWO4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUFWO4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUFWO4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:56:34 -0400
Received: from zero.aec.at ([193.170.194.10]:4359 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265979AbUFWOyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:54:41 -0400
To: Timm Morten Steinbeck <timm.steinbeck@kip.uni-heidelberg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Precise Accounting for 2.6.7
References: <2ah51-6Va-35@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 23 Jun 2004 16:54:38 +0200
In-Reply-To: <2ah51-6Va-35@gated-at.bofh.it> (Timm Morten Steinbeck's
 message of "Wed, 23 Jun 2004 16:40:11 +0200")
Message-ID: <m33c4m495d.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timm Morten Steinbeck <timm.steinbeck@kip.uni-heidelberg.de> writes:

> Hi,
>
> we have ported our x86 precise accounting patch from the 2.4 kernel
> series to 2.6.7.

[...]

On many SMP systems it will not be very precise after longer uptimes
because the TSCs of the CPUs drift away noticeable and timestamps
from different CPUs cannot be really compared.

-Andi

