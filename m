Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUD3QlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUD3QlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUD3QlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:41:20 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:5895 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265107AbUD3QlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:41:19 -0400
Date: Fri, 30 Apr 2004 17:41:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [RFC] Revised CKRM release
Message-ID: <20040430174117.A13372@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shailabh Nagar <nagar@watson.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ckrm-tech <ckrm-tech@lists.sourceforge.net>
References: <4090BBF1.6080801@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4090BBF1.6080801@watson.ibm.com>; from nagar@watson.ibm.com on Thu, Apr 29, 2004 at 04:25:21AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The basic concepts and motivation of CKRM remain the same as described
> in the overview at http://ckrm.sf.net. Privileged users can define
> classes consisting of groups of kernel objects (currently tasks and
> sockets) and specify shares for these classes. Resource controllers,
> which are independent of each other, can regulate and monitor the
> resources consumed by classes e.g the CPU controller will control the
> CPU time received by a class etc. Optional classification engines,
> implemented as kernel modules, can assist in the automatic
> classification of the kernel objects (tasks/sockets currently) into
> classes.

I'd still love to see practical problems this thing is solving.  It's
a few thousand lines of code, not written to linux style guidelines,
sometimes particularly obsfucated with callbacks all over the place.

I'd hate to see this in the kernel unless there's a very strong need
for it and no way to solve it at a nicer layer of abstraction, e.g.
userland virtual machines ala uml/umlinux.

