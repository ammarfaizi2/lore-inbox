Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVCSNy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVCSNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCSNyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:54:17 -0500
Received: from main.gmane.org ([80.91.229.2]:33496 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262584AbVCSNut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:50:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Sat, 19 Mar 2005 15:50:16 +0200
Message-ID: <pan.2005.03.19.13.50.15.938352@yahoo.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Gmane-MailScanner: Found to be clean
Cc: acpi-devel@lists.sourceforge.net
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 13:38:57 -0800, Rajesh Shah wrote:

> Here is a series of patches to support ACPI hot-add of a root bridge
> hierarchy. The added hierarchy may contain other p2p bridges and end/leaf
> I/O devices too. The root bridge itself is assumed to have been assigned
> resource ranges, but the p2p bridges and end devices are not required to
> be initialized by firmware. Most of the code changes are to make the
> existing code flows suitable for such a hierarchy of bridges & devices.
> 
> This code supports hot-add on ia64 only for now.It does not yet support
> I/O APIC hot-add, which is needed to make this fully functional.  The
> patches are against 2.6.11-mm4 (plus the patch needed for ia64 to boot).
> I've tested to make sure this does not break end/leaf device hotplug on
> the hotplug capable ia64 box I have.
> 
> Thanks,
> Rajesh

Does this mean that when it will be ported for i386, I will be able to
really use my Docking Station ?
Does it rescan the DSDT to find new additions to ACPI devices ?

I have an IBM docking station with a PCI bus inside and some other
devices, and when I hot plug my IBM ThinkPad T41 in it, it does not
recognize those devices. Only if I boot in dock they are usable.
And the DSDT is different if I boot in dock or not.
So I wander if this patch would help me to hot plug my T41 in the dock and
all devices will be recognized. (when the patch will be for i386 too)


Thx,
Paul

