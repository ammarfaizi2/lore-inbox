Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318998AbSHSTeU>; Mon, 19 Aug 2002 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318999AbSHSTeU>; Mon, 19 Aug 2002 15:34:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10489 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318998AbSHSTeT>; Mon, 19 Aug 2002 15:34:19 -0400
Subject: Re: klibc and logging
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
In-Reply-To: <3D612AF5.4080808@zytor.com>
References: <3D58B14A.5080500@zytor.com>
	<20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com>
	<20020819175429.C17471@flint.arm.linux.org.uk> <3D61239A.7030405@zytor.com>
	<20020819182542.D17471@flint.arm.linux.org.uk>  <3D612AF5.4080808@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 20:37:28 +0100
Message-Id: <1029785848.19376.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 18:29, H. Peter Anvin wrote:
> <THINKING OUT LOUD>
> 
> I wonder if it'd make sense to have /dev/kmsg0..7 that would tack on the
> priority automatically.

That stops you doing partial lines in a syslog message. It breaks if we
later add more levels. Stupid is good in this case

