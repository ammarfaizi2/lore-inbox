Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269226AbRHQAuH>; Thu, 16 Aug 2001 20:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRHQAte>; Thu, 16 Aug 2001 20:49:34 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:16308 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269291AbRHQAsV>;
	Thu, 16 Aug 2001 20:48:21 -0400
Subject: Re: /dev/random in 2.4.6
From: Robert Love <rml@tech9.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Steve Hill <steve@navaho.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010816131112.V31114@turbolinux.com>
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int>
	<Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho> 
	<20010816131112.V31114@turbolinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 20:49:01 -0400
Message-Id: <998009344.664.72.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 13:11:12 -0600, Andreas Dilger wrote:
> That said, there are still cases where network traffic _has_ to be enough
> for /dev/random, given that some firewalls (e.g. LRP) can run from only
> ramdisk, so have no other source of entropy than the network traffic.

I put together a patch that addresses this, it allows the user to
configure whether or not network devices contribute to the entropy pool.
more information can be found
-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

