Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315231AbSD3WPi>; Tue, 30 Apr 2002 18:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315237AbSD3WPh>; Tue, 30 Apr 2002 18:15:37 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:47520 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id <S315231AbSD3WPg>;
	Tue, 30 Apr 2002 18:15:36 -0400
Message-ID: <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu>
Subject: what replaces tq_scheduler in 2.4
Date: Tue, 30 Apr 2002 17:15:35 -0500
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

It seems that tq_scheduler disappears in Linux 2.4. SO what can I do if I
need to do something when the scheduler wakes up. The old code likes

queue_task(&myqueue, &tq_scheduler);

Thanks

