Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264385AbRFHW5A>; Fri, 8 Jun 2001 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264393AbRFHW4u>; Fri, 8 Jun 2001 18:56:50 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:35096 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S264385AbRFHW4j>; Fri, 8 Jun 2001 18:56:39 -0400
Subject: Re: Is Kernel2.2 is SMP versioned by default?
From: Robert Love <rml@ufl.edu>
To: jalaja devi <jala_74@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010608145848.8371.qmail@web13707.mail.yahoo.com>
In-Reply-To: <20010608145848.8371.qmail@web13707.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 08 Jun 2001 18:56:39 -0400
Message-Id: <992041001.9209.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Jun 2001 07:58:48 -0700, jalaja devi wrote:
> Hi,
> Could anyone plz tell me whether the kernel - 2.2.14
> is SMP or NON-SMP by default?
> To make it SMP versioned, Do I need to add some flags
> in the kernel header files and re-compile to kernel?

i actually think it may be SMP (for whatever odd reason).
you need to configure and compile the kernel, anyhow.
select from one of:

make config (text)
make menuconfig (curses)
make xconfig (Tk)

and make sure SMP is enabled, as well as support for the rest of your
hardware and the features you want.

then: make dep clean bzImage modules

see the Kernel Compile HOWTO

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

