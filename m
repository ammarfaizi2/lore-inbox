Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKCJqM>; Fri, 3 Nov 2000 04:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbQKCJqD>; Fri, 3 Nov 2000 04:46:03 -0500
Received: from hoser.dsl.xmission.com ([198.60.114.66]:6483 "EHLO
	hoser.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S129130AbQKCJps>; Fri, 3 Nov 2000 04:45:48 -0500
Date: Fri, 3 Nov 2000 02:45:35 -0700
From: Kurt Wall <kwall@kurtwerks.com>
To: Laurent.Kersten@alcatel.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: Include file problem with kernel 2.2.16 (seems to be the same with 2.2.17)
Message-ID: <20001103024535.B1532@hoser.kurtwerks.com>
In-Reply-To: <C125698C.003444F5.00@bemail04.net.alcatel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <C125698C.003444F5.00@bemail04.net.alcatel.be>; from Laurent.Kersten@alcatel.be on Fri, Nov 03, 2000 at 10:30:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 10:30:54AM +0100, Laurent.Kersten@alcatel.be wrote:
% 
% 
% Hello,
% 
% I've found an unfortunate bug in the "linux/timex.h" file.  This file 
% include "sys/time.h" and this cause any program that use the adjtimex 
% syscall to be unable to compile (You get a lot of multiple definition 
% error message). The only work-around, I've
% made is to comment the "#include <sys/time.h>" line and add it  myself 
% in my  (user-mode) program that use the adjtimex syscall.

If you're working in user space, #include <sys/timex.h>.  Can't 
reproduce your problem without seeing the code in question.

Kurt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
