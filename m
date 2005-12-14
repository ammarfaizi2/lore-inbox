Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbVLNCRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbVLNCRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbVLNCRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:17:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030420AbVLNCRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:17:05 -0500
Date: Tue, 13 Dec 2005 21:16:44 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tony.luck@intel.com, holt@sgi.com
Subject: Re: [IA64] Change SET_PERSONALITY to comply with comment in binfmt_elf.c.
Message-ID: <20051214021644.GA19695@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	tony.luck@intel.com, holt@sgi.com
References: <200512130159.jBD1xm1p022559@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512130159.jBD1xm1p022559@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 05:59:48PM -0800, Linux Kernel wrote:
 > tree 64fc1ba7d4734ea5ecec8942795b32a32e4623a4
 > parent acb7f67280128a9ddaa756ff10212391d28caec4
 > author Robin Holt <holt@sgi.com> Tue, 06 Dec 2005 08:02:31 -0600
 > committer Tony Luck <tony.luck@intel.com> Wed, 07 Dec 2005 01:12:34 -0800
 > 
 > [IA64] Change SET_PERSONALITY to comply with comment in binfmt_elf.c.

This introduces a compile failure.

arch/ia64/kernel/process.c: In function 'flush_thread':
arch/ia64/kernel/process.c:731: error: 'IA32_PAGE_OFFSET' undeclared (first use in this function)
arch/ia64/kernel/process.c:731: error: (Each undeclared identifier is reported only once
arch/ia64/kernel/process.c:731: error: for each function it appears in.)

		Dave

