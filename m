Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270321AbRHWUzd>; Thu, 23 Aug 2001 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRHWUzX>; Thu, 23 Aug 2001 16:55:23 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:24148 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S270347AbRHWUzK>; Thu, 23 Aug 2001 16:55:10 -0400
Date: Thu, 23 Aug 2001 16:55:26 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc bug causing problem in kernel builds
Message-ID: <20010823165526.F4385@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <3B855C19.7A4233BF@SteelEye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B855C19.7A4233BF@SteelEye.com>; from Paul.Clements@SteelEye.com on Thu, Aug 23, 2001 at 03:40:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 03:40:09PM -0400, Paul Clements wrote:
> Does anyone know if the structure misalignment problem in gcc 2.96 is a
> known issue? (could this bug be induced by a RedHat-applied gcc patch,
> if there are any)

There are some patches applied (something like ~350 patches), but as
gcc 3.0.1 and gcc CVS head behave the same way as gcc-2.96-RH, it is not RH
specific.
Looking into it.

	Jakub
