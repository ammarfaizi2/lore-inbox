Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSD2WWv>; Mon, 29 Apr 2002 18:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSD2WWu>; Mon, 29 Apr 2002 18:22:50 -0400
Received: from jalon.able.es ([212.97.163.2]:41951 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315222AbSD2WWt>;
	Mon, 29 Apr 2002 18:22:49 -0400
Date: Tue, 30 Apr 2002 00:22:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Wanghong Yuan <wyuan1@ews.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accurately measure CPU cycles used by a program? thanks
Message-ID: <20020429222243.GC1732@werewolf.able.es>
In-Reply-To: <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.30 Wanghong Yuan wrote:
>Is there any package or program, which can be used to accurately measure the
>CPU cycles used by a program? I think the following code can only provide an
>inaccurate one, beause it may count on the waiting time of the program.
>
>gettimeofday(t1)
>runprogam
>gettimeofday(t2)
>t2-t1
>
>If I need to instrument the kernel, which part I should investigate? Thanks
>a lot in advance
>

man getrusage

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam7 #1 SMP jue abr 25 00:19:56 CEST 2002 i686
