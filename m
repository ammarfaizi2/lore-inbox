Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264103AbRFLByn>; Mon, 11 Jun 2001 21:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264113AbRFLByd>; Mon, 11 Jun 2001 21:54:33 -0400
Received: from smarty.smart.net ([207.176.80.102]:16399 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S264103AbRFLByY>;
	Mon, 11 Jun 2001 21:54:24 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106120202.WAA27885@smarty.smart.net>
Subject: Re: Task Switching in Linux
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Jun 2001 22:02:53 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
>
> In Linux , If we assume that there are only 2 tasks A and B and both are
> equal , this is correct or not :-
>
> TASK A -> schedule -> switch_to -> TASK B -> schedule -> switch_to ->
> schedule -> switch_to -> TASK A.
>

If you mean "->" as "specifically calls" then that looks like cooperative
multi-tasking, which is what kernel threads AND the Linux userland
scheduler do. If an in-kernel thread doesn't call schedule, it keeps the
CPU. See the H3rL stuff in ftp://linux01.gwdg.de/pub/cLIeNUX/interim

Rick Hohensee
:; cLIeNUX /dev/tty11  21:00:45   /
:;d -d */
Cintpos/     boot/        device/      incoming/    owner/       temp/
Debian/      command/     floppy/      log/         source/
Linux/       configure/   guest/       lost+found/  subroutine/
NetBSD/      dev/         help/        mounts/      suite/

