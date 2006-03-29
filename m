Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWC2XLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWC2XLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWC2XLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:11:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61623 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751223AbWC2XLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:11:22 -0500
Date: Wed, 29 Mar 2006 18:11:00 -0500
From: Dave Jones <davej@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
Message-ID: <20060329231100.GI452@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <michael@ellerman.id.au>
References: <200603230714.k2N7EmH1021685@hera.kernel.org> <20060329195212.GA19236@redhat.com> <17451.866.287446.68155@cargo.ozlabs.ibm.com> <20060329220701.GE452@redhat.com> <17451.4345.531029.950930@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17451.4345.531029.950930@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:58:01AM +1100, Paul Mackerras wrote:
 > Dave Jones writes:
 > 
 > > See firmware_has_feature() in include/asm-powerpc/firmware.h
 > 
 > In my clone of Linus' linux-2.6 tree, it looks like this:
 > 
 > #define firmware_has_feature(feature)					\
 > 	((FW_FEATURE_ALWAYS & (feature)) ||				\
 > 		(FW_FEATURE_POSSIBLE & powerpc_firmware_features & (feature)))
 > 
 > Perhaps you need to do another pull?
 
Ah, it hadn't made it into a -git release yet.
git17 was still busted.
I see the commit on the commits-list though, so I'll
just twiddle my thumbs until git18 :-)

thanks,

		Dave

-- 
http://www.codemonkey.org.uk
