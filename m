Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319106AbSHFMr3>; Tue, 6 Aug 2002 08:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319108AbSHFMr3>; Tue, 6 Aug 2002 08:47:29 -0400
Received: from jdike.solana.com ([198.99.130.100]:14208 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S319106AbSHFMr2>;
	Tue, 6 Aug 2002 08:47:28 -0400
Message-Id: <200208061253.g76CrOT05986@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 13:13:56 +0200."
             <20020806131356.61ece6ca.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 08:53:24 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> It will let the incoming process take over ownership of the socket,
> which is probably what you mean and what you currently use. 

Yup.

> On iret it would have to change ownership of the socket to another
> task, i.e. process with kernel_pid wants to set task_pid as the owner
> of the socket. The above code fragment doesn't permit this, as far as
> I can see.

Why not?  There is nothing there that prevents that.

				Jeff

