Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWG3Lr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWG3Lr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWG3Lr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:47:29 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:51179 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932275AbWG3Lr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:47:29 -0400
Date: Sun, 30 Jul 2006 12:47:22 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jan Dittmer <jdi@l4x.org>
Cc: Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730114722.GA26046@srcf.ucam.org>
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CC993B.6070309@l4x.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 01:34:19PM +0200, Jan Dittmer wrote:

> Why not get rid of the daemon like bsd did [0]? Otherwise in
> 5 years you'll have 42 daemons running which communicate with
> the firmware of various devices, each having a different inter-
> face.

Because it would involve a moderate rewriting of the driver, and we'd 
have to carry a delta against Intel's code forever.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
