Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758161AbWLATps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbWLATps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758823AbWLATps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:45:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758161AbWLATps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:45:48 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1165001705.5257.959.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Dec 2006 20:45:45 +0100
Message-Id: <1165002345.3233.104.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 14:35 -0500, Ben Collins wrote:
> What about the point that userspace (udev, and such) is not available
> when DSDT loading needs to occur? Init hasn't even started at that
> point.

that's a moot point; you need to load firmware from the initramfs ANYWAY
for things like qlogic and others...




-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

