Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTDOLtp (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTDOLtp 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:49:45 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:51585
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S261242AbTDOLto 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:49:44 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	<p73adesxane.fsf@oldwotan.suse.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 14:00:45 +0200
In-Reply-To: <p73adesxane.fsf@oldwotan.suse.de>
Message-ID: <yw1xptno7yxe.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> > What magic needs to be done when writing modules for linux 2.5.x?
> > Insmod tells me "Invalid module format" and the kernel log says "No
> > module found in object".  I've tried to mimic the foo.mod.c stuff in
> > the kernel tree, but I can't figure out the right way to do it.
> 
> Welcome to the wonderful new world of in kernel module loading, finally
> with understandable error messages. Now bad error reporting is not limited
> to netlink anymore.
> 
> You need -DKBUILD_BASENAME=name

Should I also add -DKBUILD_MODNAME=name?

-- 
Måns Rullgård
mru@users.sf.net
