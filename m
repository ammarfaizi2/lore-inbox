Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbSJGRFH>; Mon, 7 Oct 2002 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbSJGRFH>; Mon, 7 Oct 2002 13:05:07 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:27890 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262557AbSJGRFE>; Mon, 7 Oct 2002 13:05:04 -0400
Subject: Re: [RFC][PATCH] HZ as a config option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA1BD51.6040003@us.ibm.com>
References: <3D9E1BEA.7060804@us.ibm.com>
	<1033779196.1335.8.camel@irongate.swansea.linux.org.uk> 
	<3DA1BD51.6040003@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 18:19:23 +0100
Message-Id: <1034011163.25892.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 17:58, Dave Hansen wrote:
> > You can't set this arbitarily, the NTP PLL's will only lock for certain
> > value ranges.
> 
> Where can I find these ranges?  include/linux/timex.h only errors if 
> the number is out of the 12-1535 range.

See Rolf Fokkens message on 21st Sept for one bit about it, there was
another thread about error ranges as well

