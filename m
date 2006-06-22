Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWFVPwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWFVPwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWFVPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:52:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45586 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751377AbWFVPwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:52:31 -0400
Date: Thu, 22 Jun 2006 17:52:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm1: kernel/lockdep.c: write-only variables
Message-ID: <20060622155230.GG9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following variables in kernel/lockdep.c are write-only:
  nr_hardirq_read_safe_locks
  nr_hardirq_read_unsafe_locks
  nr_hardirq_safe_locks
  nr_hardirq_unsafe_locks
  nr_softirq_read_safe_locks
  nr_softirq_read_unsafe_locks
  nr_softirq_safe_locks
  nr_softirq_unsafe_locks

Is a usage pending or should they be removed?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

