Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUDOTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDOTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:24:16 -0400
Received: from zero.aec.at ([193.170.194.10]:50955 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262481AbUDOTYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:24:13 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
References: <1Ljts-1eQ-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 15 Apr 2004 21:24:09 +0200
In-Reply-To: <1Ljts-1eQ-29@gated-at.bofh.it> (Marcelo Tosatti's message of
 "Thu, 15 Apr 2004 20:10:14 +0200")
Message-ID: <m37jwhqc2u.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> Jeff Garzik sent me a SATA update to be merged in 2.4.x. 
>
> A lot of new boxes are shipping with SATA-only disks, and its pretty bad
> to not have a "stable" series without such industry-standard support.
>
> This is the last feature to be merged on 2.4.x, and only because its quite 
> necessary.
>
> Any oppositions?

The big problem is that the SATA code will move some disks from
/dev/hdX to /dev/sdX (e.g. most disks in modern intel chipsets) And
then the boxes don't boot anymore. It's probably a bad idea to merge
it.

-Andi

