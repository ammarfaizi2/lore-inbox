Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTD3PXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTD3PXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:23:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13718
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262282AbTD3PXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:23:12 -0400
Subject: Re: Bug in linux kernel when playing DVDs.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EAFEA83.9030301@superbug.demon.co.uk>
References: <3EABB532.5000101@superbug.demon.co.uk>
	 <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
	 <3EAE220D.4010602@cyberone.com.au>
	 <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua>
	 <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk>
	 <3EAFEA83.9030301@superbug.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051713133.19579.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 15:32:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 16:23, James Courtier-Dutton wrote:
> When an error occurs on the DVD, "read done" message is never printed on 
> the console and all applications fail to respond to user input. This is 
> why I thought that the kernel hogs CPU 100% and the application never 
> receives the error message.

Can you provide me with an strace and the log of the same set of events.
In my case I saw the app I used continually going read/read/read and the
kernel working hard to clean up the mess getting an error and repeat

