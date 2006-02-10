Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWBJSZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBJSZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBJSZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:25:03 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:59078 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751306AbWBJSZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:25:00 -0500
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: a couple of oopses with 2.6.14
Date: Fri, 10 Feb 2006 19:24:44 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de> <20060209152744.00de43f6.akpm@osdl.org>
In-Reply-To: <20060209152744.00de43f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602101924.45467.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you test 2.6.15?

Yes, 2.6.15.3 works, no oopses. Only this information 

[4294743.341000] scsi0 : ata_piix
[4294743.514000] ATA: abnormal status 0x7F on port 0xE407

I can't test if sata works, there's just nothing connected.

Btw, the printk timing information seem to be uninitalized, is this by 
intentention or is it a bug?

Thanks,
	Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
