Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270010AbRHJUFl>; Fri, 10 Aug 2001 16:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270004AbRHJUFV>; Fri, 10 Aug 2001 16:05:21 -0400
Received: from ns.suse.de ([213.95.15.193]:50187 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270005AbRHJUFS>;
	Fri, 10 Aug 2001 16:05:18 -0400
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network device aliases
In-Reply-To: <200108100327.EAA22951@mauve.demon.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Aug 2001 22:05:28 +0200
In-Reply-To: Ian Stirling's message of "10 Aug 2001 05:46:42 +0200"
Message-ID: <oupd763istz.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling <root@mauve.demon.co.uk> writes:

> I think I've more or less worked out how network devices are initiated,
> and configured, with the help of the htmlised sources, but am not
> finding anything on how aliases (eth0:1 ...) work.
> Do they have an entire device structure that only differs in name and
> IP address?

In 2.0 they had. In 2.2+ they are just another entry on a per interface
address list. The notion of alias interfaces is just emulated for 
compatibility, they really do not exist anymore.

-Andi
