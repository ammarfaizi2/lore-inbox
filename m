Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272199AbSISScb>; Thu, 19 Sep 2002 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbSISScb>; Thu, 19 Sep 2002 14:32:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:30456
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S272199AbSISScb>; Thu, 19 Sep 2002 14:32:31 -0400
Subject: Re: 2.4.18 serial drops characters with 16654
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dchristian@mail.arc.nasa.gov
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209191124.24964.dchristian@mail.arc.nasa.gov>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE>
	<200209191027.46127.dchristian@mail.arc.nasa.gov>
	<1032457132.27721.45.camel@irongate.swansea.linux.org.uk> 
	<200209191124.24964.dchristian@mail.arc.nasa.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 19:42:13 +0100
Message-Id: <1032460933.27721.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 19:24, Dan Christian wrote:
> This still isn't getting at the core problem.  I'm sending data out the 
> port and dropping characters.  The receive works fine.
> 
> It can't be a problem with the receiving device being over-run, since 
> the 16550 works (even though it sends several bytes after CTS drops), 
> and the 16654 doesn't (it stops after the current byte).

What happens if you setserial it to a 16450 ?

