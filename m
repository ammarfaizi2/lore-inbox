Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311645AbSCNQM1>; Thu, 14 Mar 2002 11:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311646AbSCNQMI>; Thu, 14 Mar 2002 11:12:08 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:18136 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311645AbSCNQMB>; Thu, 14 Mar 2002 11:12:01 -0500
Date: Thu, 14 Mar 2002 17:11:59 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: Jesse Barnes <jbarnes@sgi.com>
cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
In-Reply-To: <Pine.LNX.4.21.0203141459260.12844-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.21.0203141709310.12844-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Erich Focht wrote:

> the task is currently running. Hackbench might slow down a bit but
> AIM7 should improve.

Grrr, AIM7 doesn't exec(), either :-( , so no initial balancing is
done. I'll take that back into do_fork()...

Regards,
Erich


