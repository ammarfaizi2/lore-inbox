Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUJNSUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUJNSUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJNSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:20:29 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:21643 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266155AbUJNRX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:23:26 -0400
To: Norbert Preining <preining@logic.at>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       debian-alpha@lists.debian.org, linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at>
	<20041013233247.A11663@jurassic.park.msu.ru>
	<20041014130035.GA4152@gamma.logic.tuwien.ac.at>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Thu, 14 Oct 2004 19:23:12 +0200
In-Reply-To: <20041014130035.GA4152@gamma.logic.tuwien.ac.at> (Norbert
 Preining's message of "Thu, 14 Oct 2004 15:00:35 +0200")
Message-ID: <yw1xis9d8b9b.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> writes:

> Dear Ivan, dear kernel kackers!
>
> On Mit, 13 Okt 2004, Ivan Kokshaysky wrote:
>> > 	make bootpfile
>
> Ok, now I have a boot file but the kernel is not started:
>
>>>> boot ewa0 -fl ...
> ...
> jumping to bootstrap code
> Linux/AXP bootp loader for linux 2.4.27
> Switching to OSF PAL-code .. 0k (rev 1000800020117)
> Loading the kernel...'root=/dev/sda1'
>
> Halted CPU 0
>
> halt code = 2
> kernel stack not valid halt
> PC = 200000000
> boot failure

Try building more things as modules instead of builtin, if possible.

-- 
Måns Rullgård
mru@mru.ath.cx
