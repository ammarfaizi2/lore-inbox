Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269410AbUINPMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269410AbUINPMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUINPJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:09:45 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:1920
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S269378AbUINPId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:08:33 -0400
Date: Tue, 14 Sep 2004 08:08:32 -0700
From: Phil Oester <kernel@linuxace.com>
To: lkml@einar-lueck.de
Cc: "David S. Miller" <davem@davemloft.net>, hadi@cyberus.ca,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH 2/2] ip multipath, bk head (EXPERIMENTAL)
Message-ID: <20040914150832.GA5667@linuxace.com>
References: <41457848.6040808@de.ibm.com> <1095129624.1060.45.camel@jzny.localdomain> <20040913224232.4b979c7d.davem@davemloft.net> <4146E65D.6070309@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146E65D.6070309@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:38:53PM +0200, Einar Lueck wrote:
> I attached the patch the way you requested in the other thread.
> 
> Regards
> Einar

		If you say Y here, alternative routes are cached
+         in the routing cache and on cache lookup route is chosen in
+         Round Robin fashon.            

Shouldn't this instead say

If you say Y here, alternative routes are cached
in the routing cache and on cache lookup a route is chosen using
the policy selected in 'Multipath policy'

or somesuch.  IOW, round robin is not always the policy.

Phil
