Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTLWJGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 04:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLWJGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 04:06:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:23822 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265061AbTLWJGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 04:06:54 -0500
Date: Tue, 23 Dec 2003 09:02:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031223090227.A5027@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com>; from pfg@sgi.com on Mon, Dec 22, 2003 at 08:55:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 08:55:10PM -0600, Pat Gefre wrote:
> + Well, the pci-reorg patch is just wrong with tht remaining stuff
> + and breaks the portable I/O code for IP27 and SN2 I'm working on.
> 
> I have not heard any compelling reasons for keeping non-ia64, non-Altix
> code in the ia64, Altix code base. The code re-org is aimed towards a
> new ASIC we are working on - we feel it is needed.

Again, you can reorganize code as much as you want.  Just don't change
macro names randomly.  And the reason is once again that there will be
a code drop supporting SN2 and IP27 in the same codebase soon, going
the usual linux way of architecture-independant drivers for common hardware.

> + issues before merging, it's not that much anyway..
> 
> I think I did. I sent another email with the changes I made for the
> issues you raised - and updated the patches. If I missed any, please
> let me know.

Ok, I haven't looked at that yet.

> David or Andrew can you take these patches ?

Please backpourt the renaming first.

