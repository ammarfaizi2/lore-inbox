Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSHAM5H>; Thu, 1 Aug 2002 08:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318865AbSHAM5H>; Thu, 1 Aug 2002 08:57:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10991 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318860AbSHAM5H>; Thu, 1 Aug 2002 08:57:07 -0400
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Lincoln Dale <ltd@cisco.com>,
       David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
In-Reply-To: <771740373.1028147661@[10.10.2.3]>
References: <200208010133.g711Xq7338295@saturn.cs.uml.edu> 
	<771740373.1028147661@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 15:16:11 +0100
Message-Id: <1028211371.14865.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 04:34, Martin J. Bligh wrote:

> Is it somehow impossible to just export HZ in /proc, and read it?
> Doesn't seem too hard to me.

Its "100" for x86. HZ is a constant. Thats why the kernel has to keep
the values in terms of HZ published in the same format

