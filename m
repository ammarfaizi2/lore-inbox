Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUI3AkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUI3AkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUI3AkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:40:15 -0400
Received: from ozlabs.org ([203.10.76.45]:5060 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269216AbUI3AkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:40:11 -0400
Date: Thu, 30 Sep 2004 10:38:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930003846.GB25001@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929194730.GA6292@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 09:47:30PM +0200, Olaf Hering wrote:
>  On Mon, Sep 13, David Gibson wrote:
> 
> > Andrew, please apply.  This patch has been tested both on SLB and
> > segment table machines.  This new approach is far from the final word
> > in VSID/context allocation, but it's a noticeable improvement on the
> > old method.
> 
> This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> Hangs after 'returning from prom_init', wants a power cycle.

Have you isolated the problem to the VSID allocation patch?  I think
there may have been a number of ppc64 changes which went into
2.6.9-rc2-bk2.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
