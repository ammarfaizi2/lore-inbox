Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933669AbWKWNNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933669AbWKWNNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbWKWNNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:13:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57800 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933669AbWKWNNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:13:00 -0500
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061123112251.7976994c@localhost.localdomain>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
	 <1164269159.31358.769.camel@laptopd505.fenrus.org>
	 <20061123112251.7976994c@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 14:12:46 +0100
Message-Id: <1164287566.31358.786.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 11:22 +0000, Alan wrote:
> > is this really the right thing? You're overriding a user chosen
> > configuration here.... while that might be justifiable.. it's probably a
> > good idea to at least provide a safety-valve for this one. The user
> > might have made that selection very deliberately.
> 
> Its what we do for other similar cases and I think its the right thing to
> do in this situation. One reason for this is that with multi-boot boxes
> you have to set the BIOS option to the dumbest one unless the smart OS's
> reconfigure the device.

while I can appreciate that.. it does assume things like SMM not
assuming things about it; and on resume.. has to happen as again/well :)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

