Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279297AbRJWHID>; Tue, 23 Oct 2001 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279299AbRJWHHw>; Tue, 23 Oct 2001 03:07:52 -0400
Received: from [213.237.118.153] ([213.237.118.153]:2176 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S279297AbRJWHHm>;
	Tue, 23 Oct 2001 03:07:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Date: Tue, 23 Oct 2001 09:05:20 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.10.10110220950310.1738-100000@transvirtual.com> <15vjsl-0KiiUiC@fmrl04.sul.t-online.com>
In-Reply-To: <15vjsl-0KiiUiC@fmrl04.sul.t-online.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15vvco-0000DJ-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 20:35, Tim Jansen wrote:
> On Monday 22 October 2001 18:51, James Simmons wrote:
> > > And if two processes need to access it it should be managed by a
> > > daemon.
> >
> > And if the daemon dies you could end up with a broken mouse if using
> > force feedback.
>
> But you have the same problem when the kernel driver dies. So moving the
> daemon into the kernel won't help.
>
> bye...
>
Kernel drivers are not supposed to fail. We can't assume the same about 
userspace programs.
