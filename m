Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTDSWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDSWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:48:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59600
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263487AbTDSWs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:48:28 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87lly6flrz.fsf@deneb.enyo.de>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	 <87lly6flrz.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789745.3961.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 23:02:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 18:18, Florian Weimer wrote:
> Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
> > Most I came across have only small problems (few dead sectors),
> 
> IDE disks automatically remap defective sectors, so you won't see any
> of them unless the disk is already quite broken.

You will if it writes and fails to read back. The disk can't invent a
sector that is gone. 

