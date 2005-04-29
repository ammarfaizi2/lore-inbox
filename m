Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVD1SCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVD1SCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVD1SCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:02:48 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:1183 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262198AbVD1SCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:02:47 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
Date: Fri, 29 Apr 2005 21:10:53 +0200
User-Agent: KMail/1.8
Cc: Mikael Pettersson <mikpe@csd.uu.se>, jdike@addtoit.com,
       bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org
References: <20050424181909.81B8F33AED@zion> <20050426043359.6674dc49.akpm@osdl.org>
In-Reply-To: <20050426043359.6674dc49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292110.56868.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 13:33, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> >  linux-2.6.12-paolo/arch/i386/kernel/entry.S                 |  292
> > ------------ linux-2.6.12-paolo/arch/i386/kernel/syscall_table.S        
> > |  291 +++++++++++
>
> gack.  Any time anyone touches the syscall tables I have to delicately
> rework 8,000 perfctr patches.
>
> So I folded all the perfctr patches into a single patch for now.  Later
> I'll split it out into core and architectures.
Possibly splitting away the "syscall table change" for i386 (which is the only 
one being impacted) and having the two versions (pre- and post- the other 
patches) would help...
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

