Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbREUKkd>; Mon, 21 May 2001 06:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262463AbREUKkX>; Mon, 21 May 2001 06:40:23 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:32529 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S262457AbREUKkK>;
	Mon, 21 May 2001 06:40:10 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: alpha iommu fixes
Date: 21 May 2001 09:50:56 GMT
Organization: [x] network byte order
Message-ID: <slrn9ghp80.26n.kraxel@bytesex.org>
In-Reply-To: <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: bytesex.org 990438656 2270 127.0.0.1 (21 May 2001 09:50:56 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  This without considering bttv and friends are not even trying to use the
>  pci_map_* yet, I hope you don't watch TV on your sparc64 if you have
>  enough ram.

The bttv devel versions[1] are fixed already, they should work
out-of-the box on sparc too.  Just watching TV is harmless (needs
lots of I/O bandwidth, but doesn't need much address space).
Video capture does a better job on eating iommu resources ...

  Gerd

[1] http://bytesex.org/bttv/, 0.8.x versions.

-- 
Gerd Knorr <kraxel@bytesex.org>  --  SuSE Labs, Auﬂenstelle Berlin
