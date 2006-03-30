Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWC3LMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWC3LMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWC3LMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:12:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60612 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932175AbWC3LML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:12:11 -0500
Subject: Re: Schedule for adding pata to kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>
In-Reply-To: <m3acb8eveg.fsf@lugabout.jhcloos.org>
References: <5SuEq-6ut-39@gated-at.bofh.it> <5TDme-22E-27@gated-at.bofh.it>
	 <5UAcC-3bd-3@gated-at.bofh.it> <5UH4o-4RJ-27@gated-at.bofh.it>
	 <5UTfA-5uK-17@gated-at.bofh.it> <442A9A1C.1020004@shaw.ca>
	 <m3acb8eveg.fsf@lugabout.jhcloos.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 12:20:02 +0100
Message-Id: <1143717602.29388.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-29 at 17:30 -0500, James Cloos wrote:
> My understanding is that with Alan's patch everything should be
> using major 8, and that CONFIG_IDE is no longer required, yes?

This is correct both if you are just using the existing SATA drivers or
if you are using the libata patch to drive older chips via libata.

You can mix and match but don't compile in two drivers for the same chip

Alan

