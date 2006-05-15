Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWEOLRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWEOLRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWEOLRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:17:11 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22934 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964887AbWEOLRK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:17:10 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605131106.16864.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits>
	 <200605131106.16864.dvhltc@us.ibm.com>
Date: Mon, 15 May 2006 13:20:48 +0200
Message-Id: <1147692048.3970.21.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/05/2006 13:19:30,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/05/2006 13:20:16,
	Serialize complete at 15/05/2006 13:20:16
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> These tests are running on a 4 way opteron at 2 GHz with 4 GB RAM.  I have 
> attached the .config and a listing of all the rt tasks running on the system 
> (which addresses the questions regarding priority setup, IRQ handlers, and 
> softirqs - all default).  I am running with the futex priority based wakeup 
> patches from Sebastien Duque, but I don't think this test excercises those 
> paths.

  Which watchdog are you using here? Have you tried without the 
watchdog?

  Sébastien.



