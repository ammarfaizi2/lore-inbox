Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSG3TlA>; Tue, 30 Jul 2002 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSG3TlA>; Tue, 30 Jul 2002 15:41:00 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:19462 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316106AbSG3Tk7>;
	Tue, 30 Jul 2002 15:40:59 -0400
Message-Id: <200207302047.PAA03605@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29 
In-Reply-To: Your message of "Tue, 30 Jul 2002 14:09:39 -0400."
             <20020730140939.F10315@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jul 2002 15:47:11 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> A constant address is still an option with an mmap'd device.  Just do
> an mmap of the device and assert that it is the correct value. 

Yeah, but the point of mmapping it is to allow the kernel to choose where
it goes.  The host kernel will choose one place for its processes.  UML
will choose a different place for its processes.  Everything is nice and
virtualizable.

				Jeff

