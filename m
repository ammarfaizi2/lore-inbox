Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263776AbTCVT0w>; Sat, 22 Mar 2003 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263784AbTCVT0w>; Sat, 22 Mar 2003 14:26:52 -0500
Received: from www.wireboard.com ([216.151.155.101]:40331 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S263776AbTCVT0v>; Sat, 22 Mar 2003 14:26:51 -0500
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 has O_SYNC bug ?
References: <20030322154810.A2069@verdi.et.tudelft.nl>
From: Doug McNaught <doug@mcnaught.org>
Date: 22 Mar 2003 14:37:53 -0500
In-Reply-To: Rob van Nieuwkerk's message of "Sat, 22 Mar 2003 15:48:10 +0100"
Message-ID: <m37kar42ge.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> writes:

> But the strange thing is this:  always after 30s the kernel performs
> extra writes to the CF.  It seems it's flushing some kind of dirty buffer
> from the buffer cache.  But there is not supposed to be any dirty buffer:
> all data should have been written already to the CF because the partition
> was opened with O_SYNC !

noatime?

-Doug
