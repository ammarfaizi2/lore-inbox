Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVFHTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVFHTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVFHTu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:50:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261579AbVFHTtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:49:52 -0400
Date: Wed, 8 Jun 2005 15:49:02 -0400
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: jketreno@linux.intel.com, vda@ilport.com.ua, pavel@ucw.cz,
       jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608194902.GK876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, jketreno@linux.intel.com,
	vda@ilport.com.ua, pavel@ucw.cz, jgarzik@pobox.com,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	ipw2100-admin@linux.intel.com
References: <20050608142310.GA2339@elf.ucw.cz> <200506081744.20687.vda@ilport.com.ua> <42A7268D.9020402@linux.intel.com> <20050608.124332.85408883.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608.124332.85408883.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:43:32PM -0700, David S. Miller wrote:
 
 > I am likely to always take the position that device firmware
 > belongs in the kernel proper, not via these userland and filesystem
 > loading mechanism, none of which may be even _available_ when
 > we first need to get the device going.

FWIW, I agree, though the licensing of the Intel firmware
prevents that iirc.  The biggest problem I face with this driver
in Fedora kernels is users mismatching firmware rev with the
driver version. Another problem that disappears if the two
are shipped together.

Of course this would then bring out the armchair lawyers on
the list and cause another 500 emails debating whether it
violates the gpl.

		Dave

