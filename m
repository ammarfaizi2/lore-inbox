Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSHUNcl>; Wed, 21 Aug 2002 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSHUNcl>; Wed, 21 Aug 2002 09:32:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29678 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318284AbSHUNck>; Wed, 21 Aug 2002 09:32:40 -0400
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
Cc: Rohan Deshpande <rohan@myeastern.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D6355C5.6A51E11E@hrzpub.tu-darmstadt.de>
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de>
	<3D62482D.4030500@myeastern.com>  <3D6355C5.6A51E11E@hrzpub.tu-darmstadt.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:36:15 +0100
Message-Id: <1029936975.26425.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 09:56, Jens Wiesecke wrote:
> Can anybody tell me if there is a possibility to further debug my boot
> problem, for example enabling  more verbose boot messages ?

If you have a serial port then yes booting with serial console support
enabled and something capturing ttyS0 (COM1) will give you data earlier
than the console is initialized

