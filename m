Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVLPDIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVLPDIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLPDIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:08:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751288AbVLPDIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:08:01 -0500
Date: Thu, 15 Dec 2005 22:06:24 -0500
From: Dave Jones <davej@redhat.com>
To: Neil Brown <neilb@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216030624.GA30754@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Neil Brown <neilb@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, arjan@infradead.org,
	xfs-masters@oss.sgi.com, nathans@sgi.com
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de> <20051216005056.GG3419@redhat.com> <17314.11514.650036.686071@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17314.11514.650036.686071@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:56:58PM +1100, Neil Brown wrote:

 > It turns out this is because it puts a 'struct iattr' on the stack so
 > it can kill suid if needed.  The following patch saves about 50 bytes
 > off the stack in this call path.

See! it *was* worth Adrian bringing up the "kill 8kb stacks" patch again :-)

		Dave

