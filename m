Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbTGJMIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTGJMIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:08:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64436
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269236AbTGJMIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:08:09 -0400
Subject: Re: hptraid.o -- No array found?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: seth.chromick@earthlink.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057810183.12513.5.camel@pasture.gentoo.box>
References: <20030708223548.791247f5.akpm@osdl.org>
	 <200307091106.00781.schlicht@uni-mannheim.de>
	 <20030709021849.31eb3aec.akpm@osdl.org>
	 <1057815890.22772.19.camel@www.piet.net>
	 <20030710060841.GQ15452@holomorphy.com>
	 <20030710071035.GR15452@holomorphy.com>
	 <20030710001853.5a3597b7.akpm@osdl.org>
	 <20030710075927.GS15452@holomorphy.com>
	 <1057810183.12513.5.camel@pasture.gentoo.box>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057839609.8005.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 13:20:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 05:09, Seth Chromick wrote:
> I have XP and Gentoo linux installed. In XP, my IDE RAID0 config can be
> seen and used flawlessly (highpoint). In linux, modprobe ataraid works
> fine, but modprobing hptraid gives me "Raid array not found" a few times
> and stops. Any ideas? I've googled around to no avail...

hptraid only understands a small subset of the disk layouts so not all
forms are known. Wilfried has done some really good work on this so more
formats are known by the later drivers.

Unfortunately HPT don't seem keen to document their disk layout.

