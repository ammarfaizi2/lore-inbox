Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUCaHa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCaHa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:30:27 -0500
Received: from zero.aec.at ([193.170.194.10]:14345 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261791AbUCaHa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:30:26 -0500
To: Sid Boyce <sboyce@blueyonder.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
References: <1Fylv-df-27@gated-at.bofh.it> <1FzAR-1qq-5@gated-at.bofh.it>
	<1FzAR-1qq-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 31 Mar 2004 09:30:22 +0200
In-Reply-To: <1FzAR-1qq-3@gated-at.bofh.it> (Sid Boyce's message of "Wed, 31
 Mar 2004 00:10:09 +0200")
Message-ID: <m3vfkl4goh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> writes:

> Before the messages above ---
> ********* Please consider a BIOS update.
> ********* Disabling USB legacy in the BIOS may also help.

You should really update your BIOS. With this BIOS bug you can 
get basically random crashes on 64bit systems. The kernel tries
to work around them in the idle loop, but they can happen elsewhere
too.

-Andi


