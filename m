Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132960AbRDKTTI>; Wed, 11 Apr 2001 15:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbRDKTS6>; Wed, 11 Apr 2001 15:18:58 -0400
Received: from elf.ihep.su ([194.190.161.106]:45041 "EHLO fay.elferno.lo")
	by vger.kernel.org with ESMTP id <S132960AbRDKTSo>;
	Wed, 11 Apr 2001 15:18:44 -0400
Date: Wed, 11 Apr 2001 23:18:22 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: "Eugene B. Berdnikov" <berd@elf.ihep.su>, linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411231822.A4122@fay.elferno.lo>
In-Reply-To: <20010411225051.B19364@elf.ihep.su> <200104111909.XAA10870@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104111909.XAA10870@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 11, 2001 at 11:09:35PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Wed, Apr 11, 2001 at 11:09:35PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Is the machine UP? The only other known dubious place is smp specific...

 It is a HP NetServer E40 with signle PPro-180. SMP is turned off in .config.

> BTW if that cursed socket is still alive, try to make the experiment
> with filling window on it. It must stuck, or my theory is completely wrong.

 OK. I'll try tomorrow on return to my working place. Both peer hosts are
 on UPSes and possibility to lose this connection is low. :)
-- 
 Eugene Berdnikov
