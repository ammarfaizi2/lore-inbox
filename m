Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTJAT1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJAT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:27:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1952 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262544AbTJAT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:27:51 -0400
Date: Wed, 1 Oct 2003 20:27:22 +0100
From: Dave Jones <davej@redhat.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
Subject: Re: Dave Jones: Fix cache size of Centrino CPU
Message-ID: <20031001192722.GF25612@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
References: <7F740D512C7C1046AB53446D3720017304AFD6@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFD6@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 11:55:45AM -0700, Nakajima, Jun wrote:
 > Just curious. Why do we want to know L1D/L1I cache size?

Entirely cosmetic reasons.
At boot time we print out..

Sep 21 16:38:08 hardwired kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Sep 21 16:38:08 hardwired kernel: CPU: L2 cache: 512K

 > If you do, then you might want to know the associativity and line size as well.

See http://www.codemonkey.org.uk/projects/x86info
It does all this, and more. Entirely in userspace, where such cosmetics
belong IMO.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
