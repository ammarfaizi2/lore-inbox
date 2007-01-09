Return-Path: <linux-kernel-owner+w=401wt.eu-S932185AbXAIQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXAIQQf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbXAIQQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:16:35 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:48747 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXAIQQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:16:34 -0500
Message-ID: <45A3BFAC.1030700@bull.net>
Date: Tue, 09 Jan 2007 17:15:40 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/01/2007 17:24:39,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/01/2007 17:24:40,
	Serialize complete at 09/01/2007 17:24:40
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today, there are several functionalities or improvements about futexes included
in -rt kernel tree, which, I think, it make sense to have in mainline.
Among them, there are:
	* futex use prio list : allow threads to be woken in priority order instead of
FIFO order.
	* futex_wait use hrtimer : allow the use of finer timer resolution.
	* futex_requeue_pi functionality : allow use of requeue optimisation for
PI-mutexes/PI-futexes.
	* futex64 syscall : allow use of 64-bit futexes instead of 32-bit.

The following mails provide the corresponding patches.

Comments, suggestions, feedback, etc are welcome, as usual.

-- 
Pierre Peiffer


