Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWIJKhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWIJKhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIJKhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:37:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:29509 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWIJKhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:37:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I/igxxEms+uSolWh84vvo56p5+hoGQuGEtW4awwoRQBdovo8j0mt+itDmgK63hxtIdm4Q+HXT+Kpd+3470jKH8/Bb3IX+jr3aN1rqE5Wzf1w5SUahE/92jhYjXUes0/kpAEd0hDs0MStnpqwZ23NsSKwrlJ4oD+/+v77uep01Vc=
Message-ID: <a2ebde260609100337xda27723geae84190d90293c1@mail.gmail.com>
Date: Sun, 10 Sep 2006 18:37:12 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Timer Selection
In-Reply-To: <a2ebde260609100334v65bf5e4fx754e3b00576bfb9f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609100334v65bf5e4fx754e3b00576bfb9f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In i386 architecture, there are five timers as candidates in the
selection of "cur_timer." I feel among the five only two types can be
used as Kernel base timer, HPET and PIT. Kernel base timer is the
timer trigger timer_interrupt() periodically. Namely, the timer
installed on IRQ 0 in i386 architecture.

Is the above understanding correct? Particularly I want to confirm
which timers can be used as Kernel base timer.

Thanks.

Feng,Dong
