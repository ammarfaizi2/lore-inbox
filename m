Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSIEPoG>; Thu, 5 Sep 2002 11:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSIEPoG>; Thu, 5 Sep 2002 11:44:06 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:57852
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317701AbSIEPoF>; Thu, 5 Sep 2002 11:44:05 -0400
Subject: Re: Linux on Toshiba Libretto 70CT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Weber <john.weber@linux.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D777BC0.9030004@linux.org>
References: <3D7563B2.2090707@linux.org>
	<1031138132.2796.24.camel@irongate.swansea.linux.org.uk> 
	<3D777BC0.9030004@linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 16:49:35 +0100
Message-Id: <1031240975.6623.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disabling the accelerated functions also "fixes" the machine, for some 
> definitions of "fix" :).

That sounds like an X bug then

> My question is really why this problem would lock up the kernel...
> I can't really tell whether the problem is in the implementation of the 
> XFree86 functions or the kernel functions it is calling, but the fact 
> that the entire kernel locks up suggests that both are to blame.  Can 
> you suggest where I should start reading code (if not the file atleast 
> the directory :).

X maps the video hardware and drives it directly. In that sense X is the
device driver for video not the kernel.

