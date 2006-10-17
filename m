Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWJQSh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWJQSh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJQShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:37:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:27531 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750944AbWJQShC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:37:02 -0400
Date: Tue, 17 Oct 2006 14:27:42 -0400
From: Dave Jones <davej@redhat.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Remove quirk_via_abnormal_poweroff
Message-ID: <20061017182742.GC20600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Karsten Wiese <annabellesgarden@yahoo.de>,
	linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
	Greg KH <gregkh@suse.de>
References: <200610171213.18093.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610171213.18093.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 12:13:17PM +0200, Karsten Wiese wrote:
 > Hi
 > 
 > My K8T800 mobo resumes fine from suspend to ram with and without
 > patch applied against 2.6.18.
 > quirk_via_abnormal_poweroff makes some boards not boot 2.6.18,
 > so IMO patch should go to head, 2.6.18.2 and everywhere
 > "ACPI: ACPICA 20060623" has been applied.

ACK, I applied a similar patch to the Fedora kernel which doesn't
seem to have had any immediate bad effects on the boxes I've had
access to (Tested on several different VIA systems).

Signed-off-by: Dave Jones <davej@redhat.com>

	Dave

-- 
http://www.codemonkey.org.uk
