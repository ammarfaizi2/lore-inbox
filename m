Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSKDTfH>; Mon, 4 Nov 2002 14:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSKDTfH>; Mon, 4 Nov 2002 14:35:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55697 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262653AbSKDTfG>; Mon, 4 Nov 2002 14:35:06 -0500
Subject: Re: [PATCH] add semtimedop call to kernel 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Fasheh <mfasheh@linux.ucla.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20021104192655.GJ4072@linux.ucla.edu>
References: <20021104192655.GJ4072@linux.ucla.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 20:02:51 +0000
Message-Id: <1036440171.1113.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 19:26, Mark Fasheh wrote:
> Hello,
> 	Included is a patch against 2.4.19 to allow semaphore operations
> with timeouts. The new call functions exactly like semtimedop in Solaris.
> Userspace code to use/test this new syscall can be found at:
> http://www.exothermic.org/linux/semtimedop.tar.gz
> Feedback is greatly appreciated :)

Only two feedbacks from a first glance - its a 2.5 type change not a 2.4
one. Also call your local variable something other than "jiffies" as
that is used for a global to do with time !


