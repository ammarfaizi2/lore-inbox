Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbUKKXAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbUKKXAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUKKW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:59:00 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:13060
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262410AbUKKW5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:57:05 -0500
Message-Id: <200411120109.iAC19jPV005324@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - signal bug fix 
In-Reply-To: Your message of "Thu, 11 Nov 2004 19:09:50 +0100."
             <4193AAEE.1000800@fujitsu-siemens.com> 
References: <200411111957.iABJvHPV004137@ccure.user-mode-linux.org>  <4193AAEE.1000800@fujitsu-siemens.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Nov 2004 20:09:35 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bstroesser@fujitsu-siemens.com said:
> But IMHO the solution shouldn't be resetting to the old state, that
> did syscall restarting wrong! The problem, you fix here, doesn't
> occur, when using my complete patchset. And my patches fix UML's wrong
> syscall restart handling. And other issues they fix, too. 

OK, I was trying to be minimal with those patches, and I guess I overdid it
a bit.

I'll get the rest of your changes in, and back this fix out in the process.

				Jeff

