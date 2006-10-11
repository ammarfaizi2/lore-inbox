Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWJKG73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWJKG73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWJKG73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:59:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48552 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932445AbWJKG72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:59:28 -0400
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the
	sony_acpi driver
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Yu Luming <luming.yu@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
In-Reply-To: <20061010212615.GB31972@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
	 <200610102232.46627.luming.yu@gmail.com>
	 <20061010212615.GB31972@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 08:59:04 +0200
Message-Id: <1160549944.3000.347.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 22:26 +0100, Matthew Garrett wrote:
> On Tue, Oct 10, 2006 at 10:32:46PM +0800, Yu Luming wrote:
> 
> > >From my understanding, a cute userspace App shouldn't have this kind
> > of logic:
> 
> (snip switching on hardware type)
> 
> > It should be:
> > 	just write/read  file in  /sys/class/backlight ,....
> 
> Yup, but to do that on Dell hardware is basically impossible. It'd be 
> nice if they implemented the ACPI video extension properly for future 
> hardware.

it'd also be nice if the linux-ready firmware developer kit had a test
for this, so that we can offer 1) a way to test this to the bios guys
and 2) encourage adding/note the lack easily


> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

