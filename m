Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279947AbRJ3OCi>; Tue, 30 Oct 2001 09:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279956AbRJ3OC3>; Tue, 30 Oct 2001 09:02:29 -0500
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:18706 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S279947AbRJ3OCP>; Tue, 30 Oct 2001 09:02:15 -0500
Message-Id: <200110301402.PAA00613@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: need help interpreting 'free' output.
Date: Tue, 30 Oct 2001 15:02:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be> <20011030034623.C21884@mikef-linux.matchmail.com>
In-Reply-To: <20011030034623.C21884@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op dinsdag 30 oktober 2001 12:46, schreef Mike Fedyk:
> Ahh, are you a new convert from a 2.2 kernel?
>
> In 2.4 the kernel will swap out much earlier to make room for the running
> programs, and disk cache.  This is normal.
>
> Earlier 2.4 kernels didn't do so well, but I won't go into detail because
> there is already enough about that in the archives...
>
> When you watch vmstat, if you see a lot of swapping traffic without much
> good reason, then you should probably report something...

Hi,

i already use 2.4 for some time. the thing that bugs me is the 'used' figures 
go up, and no processes actually use that memory (not the buffered/cached, 
well, they go up , but thats normal) , so it seems the memory is 'lost' 
somewhere, and i don't see any processes using it up, and 200 meg ram in 70 
seconds is a lot ...
So or i am misinterpreting something, or i am completely clueless, or there 
is a leak somewhere..

greetings,
Frank
