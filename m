Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUAMWcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbUAMWcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:32:18 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:45705
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265865AbUAMWcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:32:14 -0500
Date: Tue, 13 Jan 2004 17:44:22 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113174422.B16728@animx.eu.org>
References: <40033D02.8000207@adaptec.com> <1074031592.4981.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <1074031592.4981.1.camel@laptop.fenrus.com>; from Arjan van de Ven on Tue, Jan 13, 2004 at 11:06:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Adaptec has been looking at the MD driver for a foundation for their
> > Open-Source software RAID stack.
> 
> Hi,
> 
> Is there a (good) reason you didn't use Device Mapper for this? It
> really sounds like Device Mapper is the way to go to parse and use
> raid-like formats to the kernel, since it's designed to be independent
> of on disk formats, unlike MD.

As I've understood it, the configuration for DM is userspace and the kernel
can't do any auto detection.  This would be a "put off" for me to use as a
root filesystem.  Configurations like this (and lvm too last I looked at it)
require an initrd or some other way of setting up the device.  Unfortunately
this means that there's configs in 2 locations (one not easily available,  if
using initrd.  easily != mounting via loop!)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
