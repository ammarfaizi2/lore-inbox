Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUBXPHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUBXPHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:07:01 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:27576 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262269AbUBXPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:06:55 -0500
Subject: RE: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug 
	fix)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Feb 2004 09:06:43 -0600
Message-Id: <1077635204.2152.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 08:47, Mukker, Atul wrote:
> We are in process of releasing a unified driver, which will natively support
> the 2.4.x and 2.6.x kernels. 

I really don't think this will be such a good idea since you don't
currently have a unified driver.  2.4 is approaching end of life as far
as major driver updates go and the 2.6 APIs are quite a bit different. 
You'll find it's a lot of work for a driver that will carry you at most
six months before the distributions all switch to 2.6 and you find the
2.4 compatibility layer to be more of a hindrance than a help.

James


