Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315322AbSEAGlC>; Wed, 1 May 2002 02:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315323AbSEAGlB>; Wed, 1 May 2002 02:41:01 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:27577 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id <S315322AbSEAGlA>;
	Wed, 1 May 2002 02:41:00 -0400
Message-ID: <006101c1f0db$280bca90$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu>
Subject: suspend a thread in LKM
Date: Wed, 1 May 2002 01:41:00 -0500
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

Hi,

I am currently working a scheduling algorithm, implemented with a LKM. The
basic probelm is to control a thread (user-level) to run for x time units
every y. After x, it should wait until next y.

My current problem is that how can I let the thread wait (sleep) until next
y? I think I should put the thread in a unrunable state, and then enable it
when next y comes.  But how?

Thanks alot in advance.

w.h.y

