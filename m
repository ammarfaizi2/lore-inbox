Return-Path: <linux-kernel-owner+willy=40w.ods.org-S287023AbUKBGql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S287023AbUKBGql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S443011AbUKBGqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:46:39 -0500
Received: from fmr06.intel.com ([134.134.136.7]:61914 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S284250AbUKBGq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:46:29 -0500
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
From: Len Brown <len.brown@intel.com>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1099336966.4174.6.camel@mhcln03>
References: <1099336966.4174.6.camel@mhcln03>
Content-Type: text/plain
Organization: 
Message-Id: <1099377976.13831.195.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Nov 2004 01:46:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 14:22, Matthias Hentges wrote:
> Am Sonntag, den 31.10.2004, 23:42 -0500 schrieb Dmitry Torokhov:
> > On Sunday 31 October 2004 09:45 pm, Matthias Hentges wrote:
> > > Am Mo, den 01.11.2004 schrieb Dmitry Torokhov um 3:31:
> > > 
> > > [...]
> > > 
> > > > Can I get a binary version of it (straight out of
> /proc/acpi/dsdt) please?
> > > > The one you send was converted into C source while I need ASL.
> > > > 
> > > Sure, it's attached.
> > 
> > Hmm, i8042 already recognizes both PNP IDs from your DSDT:
> 
> [...]
> 
> > I wonder what is going on... I see there was big ACPI update in
> -mm2,
> > could you try reverting bk-acpi.patch.
> 
> I tried that, but w/o bk-acpi.patch, the kernel won't compile, sorry.
> I don't have the skills to work around that. I've attached the error
> message from "make bzImage".


With the unmodified -mm2 tree, please build with CONFIG_PNPACPI=n
and give that a go.

thanks,
-Len


