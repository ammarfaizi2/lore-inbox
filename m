Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTAGQ11>; Tue, 7 Jan 2003 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTAGQ10>; Tue, 7 Jan 2003 11:27:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:648
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267425AbTAGQ1Z>; Tue, 7 Jan 2003 11:27:25 -0500
Subject: Re: PATCH: fix "ide_scan_direction defined but not used" in ide.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107160130.GC27032@alhambra>
References: <20030107131002.GI25540@alhambra>
	 <1041957377.20658.28.camel@irongate.swansea.linux.org.uk>
	 <20030107160130.GC27032@alhambra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041960058.20658.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 17:20:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 16:01, Muli Ben-Yehuda wrote:
> Alan, I bow to your superior knowledge and judgement. However,
> 'ide_scan_direction' is only used in two places in ide.c, and both of
> those are only compiled in if CONFIG_BLK_DEV_IDEPCI:  

Move the ide_scan_direction variable into the setup-pci.c code I suspect
is the best way.


