Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311594AbSDELWM>; Fri, 5 Apr 2002 06:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSDELWB>; Fri, 5 Apr 2002 06:22:01 -0500
Received: from ns.suse.de ([213.95.15.193]:8207 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311594AbSDELVu>;
	Fri, 5 Apr 2002 06:21:50 -0500
Date: Fri, 5 Apr 2002 13:21:49 +0200
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] O(1) scheduler: lockup with set_cpus_allowed
Message-ID: <20020405132149.A16807@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.21.0204051202230.10372-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any ideas, comments?


You could just use get_task_struct/free_task_struct and drop the read lock
to make sure the target doesn't go way

-Andi
