Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFHWhv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 18:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTFHWhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 18:37:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:53156 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264015AbTFHWht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 18:37:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 9 Jun 2003 00:51:23 +0200 (MEST)
Message-Id: <UTC200306082251.h58MpNc19858.aeb@smtp.cwi.nl>
To: hpa@zytor.com, wli@holomorphy.com
Subject: Re: Maximum swap space?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    The 2GB limit is 100% userspace; distros are already shipping the
    mkswap(8) fixes (both RH & UL anyway).

If I recall things correctly: at some point in time
the kernel would reject a swapon on a swapspace that was
larger than it could handle (instead of just using the
initial part).
That is why mkswap contains a lot of very ugly code
that compares the size with the maximum certain kernels
will accept for swapon.
I have not checked recently what the present situation is.

Andries
