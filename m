Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268454AbRGXUkK>; Tue, 24 Jul 2001 16:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268452AbRGXUkB>; Tue, 24 Jul 2001 16:40:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8456 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268449AbRGXUjt>; Tue, 24 Jul 2001 16:39:49 -0400
Date: Tue, 24 Jul 2001 22:39:55 +0200
From: Jan Kara <jack@suse.cz>
To: kernel-list@kinkaid.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: dqblk or mem_dqblk for quotas?
Message-ID: <20010724223955.A14114@atrey.karlin.mff.cuni.cz>
In-Reply-To: <web-233042@kinkaid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <web-233042@kinkaid.org>; from kernel-list@kinkaid.org on Tue, Jul 24, 2001 at 10:45:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  Hello,

> Recently, I've been trying to write a utility to edit quotas
> (specifically on an ext2 filesystem), using the 2.4.x
> kernel. The man page for quotactl() on my system (RH 7.1)
> refer to the mem_dqblk struct, which is nowhere to be found
> in the source to the 2.4 kernels.
> 
> Am I missing something, or should I just continue to use the
> dqblk struct.
  It depends on version of kernel. In RH 7.1 Alan's kernel is used
and in it is new quota format -> mem_dqblk must be used.
In standard Linus's kernel dqblk should be used.

							Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs
