Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTDGTRW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTDGTRW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:17:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24982
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263598AbTDGTRV (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 15:17:21 -0400
Subject: Re: oops when using hdc=ide-scsi (2.5.66)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407120245.3a51a4f6.rddunlap@osdl.org>
References: <20030407120245.3a51a4f6.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049740232.2965.80.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 19:30:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 20:02, Randy.Dunlap wrote:
> Hi,
> 
> I get this when I boot 2.5.66 and the Linux command line contains
> "hdc=ide-scsi".  Yes, I know that I can remove that option (as in
> "DDT"), but the kernel shouldn't do this, either.

ide_scsi is completely broken in 2.5.x. Known problem. If you need it
either use 2.4 or fix it 8)

