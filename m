Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132128AbRDDUNL>; Wed, 4 Apr 2001 16:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132126AbRDDUNB>; Wed, 4 Apr 2001 16:13:01 -0400
Received: from m208-mp1-cvx1c.col.ntl.com ([213.104.76.208]:63492 "EHLO
	[213.104.76.208]") by vger.kernel.org with ESMTP id <S132122AbRDDUMq>;
	Wed, 4 Apr 2001 16:12:46 -0400
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to let all others run
In-Reply-To: <01040216053401.01575@idun>
From: John Fremlin <chief@bandits.org>
Date: 04 Apr 2001 21:11:27 +0100
In-Reply-To: Oliver Neukum's message of "Mon, 2 Apr 2001 16:05:34 +0200"
Message-ID: <m2lmpgifww.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oliver!

 Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:

> is there a way to let all other runable tasks run until they block
> or return to user space, before the task wishing to do so is run
> again ?

Are you trying to do this in kernel or something? From userspace you
can use nice(2) then sched_yield(2), though I don't know if the linux
implementations will guarrantee anything.

-- 

	http://www.penguinpowered.com/~vii
