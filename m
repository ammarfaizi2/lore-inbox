Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbTGVTwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbTGVTwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:52:02 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:19950 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S268102AbTGVTwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:52:01 -0400
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
Cc: Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1D7C80.6020605@gibraltar.at>
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
	 <3F1D7C80.6020605@gibraltar.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 21:00:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it is not expected behaviour that the kernel processes no longer 
> close their fds open an pivot_root, then I'd like to debug this (is my 
> use of pivot_root correct or am I doing something wrong here ?). I will 
> try with vanilla 2.4.21 now and see how that goes (or should I rather 
> try 2.4.22-pre7 ?).

2.4.22pre7 has the unshare_files fix - its a security fix.

It should not have changed the behaviour so I'm very interested to know if
that specific patch set changes the behaviour and precisely what your code
is doing

