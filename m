Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTD3M7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTD3M7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:59:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58517
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262157AbTD3M7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:59:21 -0400
Subject: Re: Bug in linux kernel when playing DVDs.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Nick Piggin <piggin@cyberone.com.au>, James@superbug.demon.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua>
References: <3EABB532.5000101@superbug.demon.co.uk>
	 <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
	 <3EAE220D.4010602@cyberone.com.au>
	 <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 13:07:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 13:10, Denis Vlasenko wrote:
> > Having the kernel not use 100% CPU?
> 
> I suspect IDE error recovery path was never audited for that

NOTABUG

User space keeps asking it to read so it keeps using CPU, fix the user
space

