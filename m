Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135980AbRDTSun>; Fri, 20 Apr 2001 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRDTSuX>; Fri, 20 Apr 2001 14:50:23 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:40973 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135980AbRDTSuN>;
	Fri, 20 Apr 2001 14:50:13 -0400
To: linux-kernel@vger.kernel.org
Cc: pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 20 Apr 2001 13:50:06 -0500
In-Reply-To: Victor Zandy's message of "19 Apr 2001 11:05:03 -0500"
Message-ID: <cpx8zkvz9r5.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Victor Zandy <zandy@cs.wisc.edu> writes:
> We have found that one of our programs can cause system-wide
> corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
> run this program, the FPU gives bad results to all subsequent
> processes.

We have now tested 2.4.2 and 2.2.19.

2.2.19 has the same problem.

2.4.3 does not seem to be affected.  Unfortunately, we really need a
working 2.2 kernel at this time.

We also patched the 2.2.19 kernel with the PIII patch found in
/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre13/PIII-10.bz2
on ftp.kernel.org.  Same problem.

Does anyone have any ideas for us?

Thanks.

Vic

