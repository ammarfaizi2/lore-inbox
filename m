Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTEUXpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTEUXpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:45:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32703
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262385AbTEUXpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:45:12 -0400
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duraid Madina <duraid@octopus.com.au>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3ECBD0EA.70307@octopus.com.au>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
	 <1053507692.1301.1.camel@laptop.fenrus.com>
	 <3ECB57A4.1010804@octopus.com.au>
	 <1053522732.1301.4.camel@laptop.fenrus.com> <3ECBD0EA.70307@octopus.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053557981.1630.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 May 2003 23:59:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-21 at 20:18, Duraid Madina wrote:
> "A process can relinquish the processor voluntarily without blocking by 
> calling sched_yield. The process will then be moved to the end of the 
> queue for its static priority and a new process gets to run."
> 
> How you get from there to "I'm the least important thing in the system" 
> is, once again, beyond me. And even if that were a reasonable 


Assuming nobody is niced the two say the same thing. Note "for its
_static_ priority" not for its dynamic priority. So sched_yield puts you
at the back of a pile of cpu hogs cos thats what the spec says it does

