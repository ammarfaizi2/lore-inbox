Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263197AbTCYSWt>; Tue, 25 Mar 2003 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263199AbTCYSWs>; Tue, 25 Mar 2003 13:22:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7860
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263197AbTCYSWo>; Tue, 25 Mar 2003 13:22:44 -0500
Subject: Re: Compiling options?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030325180334.GH15678@rdlg.net>
References: <20030325180334.GH15678@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048621636.28496.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2003 19:47:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 18:03, Robert L. Harris wrote:
> Ok, I currently manage a site with a couple hundred machines ranging
> from P2 through AMD-Durons.  The prevaling theory was to make a single
> kernel compiled for a "pentium classic" and then load in drivers for
> about everything under the sun.

If your boxes range from PII through to AMD duron build for 686, but the
basic theory is the same.

A 386 kernel really hurts later CPUs
A 486 kernel is generally fine
A 686 kernel speeds stuff up a little more

The only CPU that is really helped by a custom kernel is the rather rare
IDT winchip which is 10-30% faster with the right kernels

