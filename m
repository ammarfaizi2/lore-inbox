Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269335AbRHCHO1>; Fri, 3 Aug 2001 03:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269336AbRHCHOR>; Fri, 3 Aug 2001 03:14:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46146 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269335AbRHCHOC>; Fri, 3 Aug 2001 03:14:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pgallen@randomlogic.com (Paul G. Allen),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <E15SHX2-0000SZ-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Aug 2001 01:07:42 -0600
In-Reply-To: <E15SHX2-0000SZ-00@the-village.bc.nu>
Message-ID: <m1lml1y62p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
 
> > 3. The BIOS (apparently) doesn't setup the MTRR properly on both CPUs making
> mtrr bitch about a mismatch.
> 
> 
> The mtrr driver fixups should cure that - its a common bios bug.

There is some truth in that.  But note AMD hasn't released all of the
documentation related to their MTRR's so we can't rely on linux fixing
all of those BIOS bugs.   In this case it happens to be different
caching on the BIOS chip, from different cpus.

An interesting question is what is 0x1e in the AMD fixed mtrr's.

Eric
