Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRIPXJX>; Sun, 16 Sep 2001 19:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273202AbRIPXJN>; Sun, 16 Sep 2001 19:09:13 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:1718 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S273147AbRIPXJG>;
	Sun, 16 Sep 2001 19:09:06 -0400
Date: Mon, 17 Sep 2001 01:09:27 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010917010927.A9308@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 03:58:35PM -0700, Mike Fedyk <mfedyk@matchmail.com> wrote:
> #define BH_LowPrio	8	/* 1 if the buffer is lowprio */
> #define BH_Temp         8       /* 1 if the buffer is temporary (unlinked)

Change BH_Temp to:

#define BH_Temp         9       /* 1 if the buffer is temporary (unlinked)

and it should work.
                                     
-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
