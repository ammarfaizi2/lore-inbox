Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSCRMiv>; Mon, 18 Mar 2002 07:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310743AbSCRMim>; Mon, 18 Mar 2002 07:38:42 -0500
Received: from stingr.net ([212.193.33.37]:31908 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S310740AbSCRMi2>;
	Mon, 18 Mar 2002 07:38:28 -0500
Date: Mon, 18 Mar 2002 15:38:01 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
Message-ID: <20020318123801.GZ5049@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020317121954.390bc242.Felix.Braun@mail.McGill.ca> <200203180639.g2I6dVq27119@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Denis Vlasenko:
> > whereas under 2.4.18 the first line didn't show up. Is that a
> > misconfiguration on my part?
> 
> Maybe you mount devfs manually after kernel did the same?
> devfs /dev devfs rw 0 0 - most probably mounted by initscripts
> none /dev devfs rw 0 0 - by kernel

no - this is known bug at init/do_mounts.c - fixed in latest ac

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
