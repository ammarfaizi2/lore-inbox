Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSGPVv2>; Tue, 16 Jul 2002 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSGPVv1>; Tue, 16 Jul 2002 17:51:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41202 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318134AbSGPVv0>; Tue, 16 Jul 2002 17:51:26 -0400
Subject: Re: PROBLEM: Kernel panics on bootup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Snyder <csnyder@mvpsoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D34956A.7030200@mvpsoft.com>
References: <3D345AD7.1010509@mvpsoft.com>
	<1026858432.1687.85.camel@irongate.swansea.linux.org.uk> 
	<3D34956A.7030200@mvpsoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 00:04:46 +0100
Message-Id: <1026860686.1688.97.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 22:51, Chris Snyder wrote:
> Thanks for the quick reply.  Would it be possible for me to get this 
> working with only one processor, then?  The nosmp option doesn't let it 
> boot.

Firstly check if the BIOS has any kind of "OS" or "Intel MP" options. If
it has an OS option try setting it to something Unixlike. 

Next build a completely non SMP kernel and see if that boots. Let me
know what that one does because the SMP failure should not have been a
crash regardless of what it found

