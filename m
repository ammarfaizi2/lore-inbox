Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRI0Ubq>; Thu, 27 Sep 2001 16:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273883AbRI0UbZ>; Thu, 27 Sep 2001 16:31:25 -0400
Received: from ns.suse.de ([213.95.15.193]:8709 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273881AbRI0UbT>;
	Thu, 27 Sep 2001 16:31:19 -0400
To: John Kingman <kingman@VIEO.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: get_current()
In-Reply-To: <Pine.LNX.4.21.0109271518350.12110-100000@Worf.VIEO.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2001 22:31:41 +0200
In-Reply-To: John Kingman's message of "27 Sep 2001 22:22:33 +0200"
Message-ID: <oupvgi49xzm.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kingman <kingman@VIEO.com> writes:

> I'm trying to write portable driver code.
> 
> What is the status of get_current()?  I see that it is defined in

You should always just use "current" from <linux/sched.h>.
get_current() is an internal implementation detail of the architecture.
Don't include <asm/current.h> directly. 


-Andi
