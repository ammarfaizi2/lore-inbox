Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271803AbRIHSi4>; Sat, 8 Sep 2001 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271805AbRIHSir>; Sat, 8 Sep 2001 14:38:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29233 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271803AbRIHSig>; Sat, 8 Sep 2001 14:38:36 -0400
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: kernel hangs in 118th call to vmalloc
In-Reply-To: <3B8FDA36.5010206@interactivesi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Sep 2001 12:30:41 -0600
In-Reply-To: <3B8FDA36.5010206@interactivesi.com>
Message-ID: <m1ae05h6we.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <ttabi@interactivesi.com> writes:

> I'm writing a driver for the 2.4.2 kernel.  I need to use this kernel because
> this driver needs to be compatible with a stock Red Hat system. Patches to the
> kernel are not an option.
> 
> The purpose of the driver is to locate a device that exists on a specific memory
> 
> chip.  To help find it, I've written this routine:

What is wrong with using SPD to detect interesting properties of
memory chips?  That should be safer and usually easier then what you
are trying now. 

Eric
