Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVAKDeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVAKDeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVAKDa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:30:57 -0500
Received: from fmr22.intel.com ([143.183.121.14]:63389 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262557AbVAKD3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:29:45 -0500
Date: Mon, 10 Jan 2005 19:28:47 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: YhLu <YhLu@tyan.com>, Andi Kleen <ak@muc.de>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>, Matt_Domsch@dell.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110192846.A30630@unix-os.sc.intel.com>
References: <3174569B9743D511922F00A0C94314230729139F@TYANWEB> <200501101642.41783.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200501101642.41783.jamesclv@us.ibm.com>; from jamesclv@us.ibm.com on Mon, Jan 10, 2005 at 04:42:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 04:42:41PM -0800, James Cleverdon wrote:
> Personally, I don't have any problem with replacing the non-power-of-2 
> code with "hweight32(c->x86_num_cores - 1)", but folks at Intel have 
> been very insistent that it may be needed in the future.  Maybe Suresh 
> can speak up about Intel's interests here.

IA32 SDM vol3 section 7.7.5 talks about the recommended way of computing
physical processor package id. Current kernel code which is doing this, 
can definitely be made more readable. I will do that when ever I get
a chance.

thanks,
suresh
