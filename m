Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSEJJol>; Fri, 10 May 2002 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSEJJok>; Fri, 10 May 2002 05:44:40 -0400
Received: from stingr.net ([212.193.32.15]:65156 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S313238AbSEJJok>;
	Fri, 10 May 2002 05:44:40 -0400
Date: Fri, 10 May 2002 13:44:30 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Some useless cleanup
Message-ID: <20020510094430.GC1125@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020509102841.GA1125@stingr.net> <20020509223650.2d7a9f6a.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Rusty Russell:
> Your implementation using snprintf is (wasteful and) dangerous,

Some pieces inside kernel using formatted titles
for example softirqd_CPU%d
or scsi_eh_%d

(But if we eliminate them then it can end with strncpy)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
