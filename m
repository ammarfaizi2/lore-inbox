Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbTCRKiy>; Tue, 18 Mar 2003 05:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbTCRKiy>; Tue, 18 Mar 2003 05:38:54 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:64156 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262295AbTCRKix>; Tue, 18 Mar 2003 05:38:53 -0500
Message-ID: <20030318104941.28605.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2003 11:49:41 +0100
Subject: 2.5 Interactivity & XMMS audio skipping
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
While playing with 2.5.65 and 2.5.64-mm8 I've been able 
to reproduce audio skipping with XMMS while moving a 
large window on my KDE desktop (no other CPU-bound 
process except "kdeinit" waking up periodically to steal 
1-3% CPU). What's really curious is that after some time, 
the scheduler seems to adjust in such a way that I can't 
reproduce the audio skip anymore easily. 
 
In 2.5.64-mm8 it's easier to avoid sound skipping by 
adjusting "max_timeslice" to a 25 or lower. However, on 
2.5.65, I must wait for the scheduler to do its magic. After 
that time, dragging the window over the screen (either 
very fast or very slowly) does not always reproduce the 
audio skip. 
 
Thanks! 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
