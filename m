Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315220AbSD2WPT>; Mon, 29 Apr 2002 18:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315219AbSD2WPS>; Mon, 29 Apr 2002 18:15:18 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:4069 "EHLO mx2.ews.uiuc.edu")
	by vger.kernel.org with ESMTP id <S315216AbSD2WPS>;
	Mon, 29 Apr 2002 18:15:18 -0400
Message-ID: <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu>
Subject: Accurately measure CPU cycles used by a program? thanks
Date: Mon, 29 Apr 2002 17:15:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any package or program, which can be used to accurately measure the
CPU cycles used by a program? I think the following code can only provide an
inaccurate one, beause it may count on the waiting time of the program.

gettimeofday(t1)
runprogam
gettimeofday(t2)
t2-t1

If I need to instrument the kernel, which part I should investigate? Thanks
a lot in advance

Wanghong

