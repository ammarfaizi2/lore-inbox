Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSIRBEV>; Tue, 17 Sep 2002 21:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbSIRBEU>; Tue, 17 Sep 2002 21:04:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31109 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264891AbSIRBEU>;
	Tue, 17 Sep 2002 21:04:20 -0400
Date: Tue, 17 Sep 2002 18:00:14 -0700 (PDT)
Message-Id: <20020917.180014.07882539.davem@redhat.com>
To: hadi@cyberus.ca
Cc: akpm@digeo.com, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
References: <3D87A59C.410FFE3E@digeo.com>
	<Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jamal <hadi@cyberus.ca>
   Date: Tue, 17 Sep 2002 20:57:58 -0400 (EDT)
   
   I am not so sure with that 6% difference there is no other bug lurking
   there; 6% seems too large for an extra two PCI transactions per packet.

{in,out}{b,w,l}() operations have a fixed timing, therefore his
results doesn't sound that far off.

It is also one of the reasons I suspect Andrew saw such bad results
with 3c59x, but probably that is not the only reason.
