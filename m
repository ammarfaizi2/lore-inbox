Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277379AbRJENfc>; Fri, 5 Oct 2001 09:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRJENfW>; Fri, 5 Oct 2001 09:35:22 -0400
Received: from mnh-1-02.mv.com ([207.22.10.34]:64260 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S277379AbRJENfE>;
	Fri, 5 Oct 2001 09:35:04 -0400
Message-Id: <200110051453.JAA01618@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: adam.keys@HOTARD.engr.smu.edu.karaya.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Development Setups 
In-Reply-To: Your message of "Thu, 04 Oct 2001 23:20:06 EST."
             <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 09:53:13 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam.keys@engr.smu.edu said:
> Instead of having separate machines,  there is the possibility of
> using the  Usermode port.  As I understand it this lags behind the -ac
> and linus kernels  so it would be hard to test things like the new
> VM's.

Not really.  The latest UML is sometimes pretty far ahead of what's in the
-ac tree, but it usually works fine.  So, if you're interested in the generic
kernel, and not UML itself, that shouldn't be a problem.  And currently, 
the -ac tree is pretty close to my CVS.

Also, the latest patches usually go pretty cleanly into the -linus pre kernels,
so getting those running in UML shouldn't be hard.

>   Usermode would not be  suitable for driver development either.

This is just because no one has written the code to do it.  It is perfectly
possible to do hardware device driver development in UML.  Various USB people
have started trying to do USB driver development under UML, for example.

				Jeff

