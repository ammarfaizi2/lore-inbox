Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291126AbSBSKzy>; Tue, 19 Feb 2002 05:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291157AbSBSKzf>; Tue, 19 Feb 2002 05:55:35 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:56582 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291126AbSBSKzX>; Tue, 19 Feb 2002 05:55:23 -0500
Date: Tue, 19 Feb 2002 11:55:12 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 fs problem in 2.4.18-rc1?
Message-ID: <20020219105512.GA5634@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1013933289.18783.8.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013933289.18783.8.camel@psuedomode>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2002, Ed Sweetman wrote:

> I'm using 2.4.18-rc1 with the preempt patch and whenever I run fsck, it
> keeps finding more and more errors.  Specifically those related to
> corrupted orphan linked lists. I dont know what is going on but I know
> it's not the drives because they were all tested before partitioning
> under an older (woody's kernel) and everything was fine (bad block
> test).  

Can you confirm your memory is OK? I saw this behaviour on 2.4.14 or
2.4.16 (release) with a fault memory module. Run memtest86 to figure --
the kernel may trigger it now while another kernel does not because of
changed memory management.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
