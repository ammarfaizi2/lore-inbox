Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbQLRQG6>; Mon, 18 Dec 2000 11:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbQLRQGi>; Mon, 18 Dec 2000 11:06:38 -0500
Received: from whiterose.net ([199.245.105.145]:17968 "EHLO whiterose.net")
	by vger.kernel.org with ESMTP id <S129610AbQLRQGS>;
	Mon, 18 Dec 2000 11:06:18 -0500
Date: Mon, 18 Dec 2000 10:35:58 -0500 (EST)
From: M Sweger <mikesw@whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: linux 2.2.19pre1 oops on cpuid
Message-ID: <Pine.LNX.4.21.0012181029270.3478-100000@whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
   I have linux 2.2.19pre1 and have compiled the cpuid as a module. The
kernel will oops if the cpuid module isn't loaded and one does
/cat/dev/cpu/0/cpuid or /cat/dev/cpu/1/cpuid.

    Question:  Is it possible to update the ksymoops utility to a 
     newer version vs. the one supplied which  is v0.6?

     Question: When the cpuid module is loaded and I do a
cat/dev/cpu/0/cpuid it gives me a code "C" forover. What does this code
mean. I'm stil new to what it will be used for. Moreover, is there
a  list of all the possible code values it may take on for intel
processors vs. other processor types?


Thanks


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
