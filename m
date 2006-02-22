Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWBVRgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWBVRgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWBVRgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:36:41 -0500
Received: from mx1.suse.de ([195.135.220.2]:32738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161150AbWBVRgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:36:40 -0500
To: Ramon van Alteren <ramon@vanalteren.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing to an NFS share truncates files on >8Tb Raid + LVM2
References: <43FB3208.7020303@vanalteren.nl>
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2006 18:36:32 +0100
In-Reply-To: <43FB3208.7020303@vanalteren.nl>
Message-ID: <p73pslf2t3z.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon van Alteren <ramon@vanalteren.nl> writes:
> 
> Which seems to indicate that RAID + LVM + complex storage and
> 4KSTACKS can cause problems. However I can't find the 4KSTACK symbol
> anywhere in my config. Can't find the 8KSTACK symbol anywhere either :-(

4K stacks is unlikely to cause problems like this. If you have a stack
overflow things crash badly, not break subtly like they do in your case.

Sounds like a bad bug. Best you work with the NFS maintainers to 
track it down. See MAINTAINERS how to reach them.

-Andi
