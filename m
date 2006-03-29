Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWC2WHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWC2WHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWC2WHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:07:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751019AbWC2WHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:07:16 -0500
Date: Wed, 29 Mar 2006 17:07:01 -0500
From: Dave Jones <davej@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
Message-ID: <20060329220701.GE452@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <michael@ellerman.id.au>
References: <200603230714.k2N7EmH1021685@hera.kernel.org> <20060329195212.GA19236@redhat.com> <17451.866.287446.68155@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17451.866.287446.68155@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:00:02AM +1100, Paul Mackerras wrote:
 > Dave Jones writes:
 > 
 > > This (or one of the other firmware patches, I've not narrowed it down that close)
 > > breaks ppc64 oprofile.
 > > 
 > > modpost now complains with..
 > > 
 > > kernel/arch/powerpc/oprofile/oprofile.ko needs unknown symbol ppc64_firmware_features
 > 
 > That got renamed to powerpc_firmware_features.  I don't see any
 > occurrences of ppc64_firmware_features left anywhere in the tree.  Are
 > you sure you don't just need to make clean and rebuild?

See firmware_has_feature() in include/asm-powerpc/firmware.h

		Dave

-- 
http://www.codemonkey.org.uk
