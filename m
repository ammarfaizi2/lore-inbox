Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271318AbRH3Fub>; Thu, 30 Aug 2001 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272077AbRH3FuV>; Thu, 30 Aug 2001 01:50:21 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:44532 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S271318AbRH3FuC>; Thu, 30 Aug 2001 01:50:02 -0400
Date: Wed, 29 Aug 2001 22:50:13 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: Elan Feingold <efeingold@mn.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multithreaded core dumps
In-Reply-To: <000c01c13113$91d7c060$0400000a@gorilla>
Message-ID: <Pine.GSO.4.10.10108292242080.10391-100000@cranford-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 0. Am I wrong or confused about the state of postmortem multithreaded
> debugging under Linux?

At least as of mid-2.2 series this was certainly my experience. It was
very frustrating that the thread/process that dumped core was not the one
that dereferenced a bad pointer/failed an assert but the process group
leader.

> 
> 2. If this is simply something that nobody is working on because other
> things are more interesting, can anybody give me a few pointers on where
> to start?
> 

I am inclined to believe that that is the case. Unfortunately, I have no
advice to give - but I am writing because I think that it would be neat if
you have the time and the inclination for you to document your findings as
you progress and put them on the web. 

			-Kip

