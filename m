Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132797AbRDKSgL>; Wed, 11 Apr 2001 14:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRDKSgA>; Wed, 11 Apr 2001 14:36:00 -0400
Received: from elf.ihep.su ([194.190.161.106]:40457 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132797AbRDKSfr>;
	Wed, 11 Apr 2001 14:35:47 -0400
Date: Wed, 11 Apr 2001 22:35:36 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411223536.A19364@elf.ihep.su>
In-Reply-To: <20010411141645.B12573@elf.ihep.su> <200104111656.UAA08925@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200104111656.UAA08925@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 11, 2001 at 08:56:41PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Wed, Apr 11, 2001 at 08:56:41PM +0400, kuznet@ms2.inr.ac.ru wrote:
> ppp also inclined to the mss/mtu bug, it allocates too large buffers
> and never breaks them. The difference between kernels looks funny, but
> I think it finds explanation in differences between mss/mtu's.

 In my experiments linux simply sets mss=mtu-40 at the start of ethernet
 connections. I do not know why, but belive it's ok. How the version of
 kernel and configuration options can affect mss later?
-- 
 Eugene Berdnikov
