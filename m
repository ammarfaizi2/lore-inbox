Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVF2BEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVF2BEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVF2BCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:02:08 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:37203 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262394AbVF2A5Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:57:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OQQLs4ZbqXFpfEnGW2a1F2Zr3xPMZ59Ylub3u0ypaoXMUdYC7nhrn9ekJ1FuqtU4UiUl1LWKwDTynD02jZLwkPPUcotq+EWYeSFwuEiU44gPv6NEu9s+S0yOqX+tVmOzGVvrwtLLyaFjo1csIbTHpq7xsoUD8MbZbby0hGn+ruM=
Message-ID: <516d7fa80506281757188b2fda@mail.gmail.com>
Date: Wed, 29 Jun 2005 00:57:21 +0000
From: Mike Richards <mrmikerich@gmail.com>
Reply-To: Mike Richards <mrmikerich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Swap partition vs swap file
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any significant difference these days between a swap
partition and a swap file?

An exhaustive Google search turns up several conflicting answers. The
consensus seems to be that a swap partition is more efficient than a
swap file, but whether or not the difference is noteworthy is never
definitively answered.

For the sake of argument, let's assume you've got modern hardware with
ample RAM and a recent kernel (a late 2.4.x or 2.6.x), and that under
normal conditions you never seeing more than 50-100MB of swap used.

Given this situation, is there any significant performance or
stability advantage to using a swap partition instead of a swap file?
