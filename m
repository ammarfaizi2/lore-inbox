Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTDSWoK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDSWoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:44:09 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57040
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263483AbTDSWoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:44:09 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030419184120.GH669@gallifrey>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	 <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com>
	 <20030419184120.GH669@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789452.3955.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 22:57:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 19:41, Dr. David Alan Gilbert wrote:
> 	2) I don't think all drives are set to remap sectors by default.

I don't know any that do not remap on write if needed. 

> 	3) I don't believe that all drivers recover neatly from a drive error.

For IDE we have some issues with ATA6 drives in certain cases at least. 

> 	2) A disc exerciser - something that I can use to see if this drive,
> 	connected to this controller, on this motherboard on this kernel
> 	actually works and keeps its data safe before I put it into live
> 	service.

SMART supports some of this. Andre also has some disk stress testing
tools

