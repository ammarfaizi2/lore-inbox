Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTBTOCu>; Thu, 20 Feb 2003 09:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBTOCu>; Thu, 20 Feb 2003 09:02:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44418
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265423AbTBTOCt>; Thu, 20 Feb 2003 09:02:49 -0500
Subject: Re: PATCH: part fix the highpoint timing/overclock bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10302192016580.11001-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10302192016580.11001-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045753988.3790.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 15:13:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 04:18, Andre Hedrick wrote:
> That will deadlock it into a death spiral beause PIO is not setup either,
> but I like the warning!

Should be ok. It'll fail to allow DMA modes so will retune the drive unless
Im missing something

