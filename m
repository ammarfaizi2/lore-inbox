Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRDNPLN>; Sat, 14 Apr 2001 11:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRDNPLE>; Sat, 14 Apr 2001 11:11:04 -0400
Received: from 1-114.ctame700-1.telepar.net.br ([200.193.160.114]:6272 "EHLO
	dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S132400AbRDNPKt>; Sat, 14 Apr 2001 11:10:49 -0400
Date: Sat, 14 Apr 2001 04:07:17 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Green" <greeen@iii.org.tw>
Cc: "LinuxKernelMailList" <linux-kernel@vger.kernel.org>,
        "MipsMailList" <linux-mips@fnet.fr>,
        "LinuxEmbeddedMailList" <linux-embedded@waste.org>
Subject: Re: I can't read data from COM1
Message-ID: <20010414040717.C659@bacchus.dhis.org>
In-Reply-To: <004101c0c0d0$33ca4b40$4c0c5c8c@trd.iii.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004101c0c0d0$33ca4b40$4c0c5c8c@trd.iii.org.tw>; from greeen@iii.org.tw on Mon, Apr 09, 2001 at 04:36:30PM +0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 04:36:30PM +0800, Green wrote:

I ran into a similar problem with 2.4.3 where I couldn't enter anything
when running mingetty on the console.  Turned out that by default the
CREAD flag isn't set on a serial interface in 2.4.3 after bootup so
you need to initialize this.

  Ralf
