Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUEMMjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUEMMjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUEMMjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:39:20 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:45532 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264182AbUEMMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:39:08 -0400
Date: Thu, 13 May 2004 13:37:39 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Fruhwirth Clemens <clemens-dated-1085311555.6f4f@endorphin.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] AES i586 optimized
Message-ID: <20040513123739.GA6046@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Fruhwirth Clemens <clemens-dated-1085311555.6f4f@endorphin.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040513110110.GA8491@ghanima.endorphin.org> <20040513121315.B8620@infradead.org> <20040513112555.GA22233@ghanima.endorphin.org> <20040513131850.A9466@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513131850.A9466@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 01:18:50PM +0100, Christoph Hellwig wrote:
 > On Thu, May 13, 2004 at 01:25:55PM +0200, Fruhwirth Clemens wrote:
 > > > advertisment clause, so GPL-incompatible.
 > > 
 > > Standard BSD license text. Listed as GPL-compatible by FSF.
 > 
 > Thanks, braino.  Didn't notice the and/or
 > 

Given the and/or, could we drop this chunk and put it somewhere
more suitable, like Documentation/ (or even the Kconfig at a push) ?
I don't think we include any other terms/license agreements
in binary form (other than MODULE_LICENSE() stuff), so why should
we special case this one?

		Dave


+copyright:
+       .ascii "    \000"
+       .ascii "Copyright (c) 2001, Dr Brian Gladman <brg@gladman.uk.net>, Worcester, UK.\000"
+       .ascii "All rights reserved.\000"
+       .ascii "    \000"
+       .ascii "TERMS\000"
+       .ascii "    \000"
+       .ascii " Redistribution and use in source and binary forms, with or without\000"
+       .ascii " modification, are permitted subject to the following conditions:\000"
+       .ascii "    \000"
+       .ascii " 1. Redistributions of source code must retain the above copyright\000"
+       .ascii "    notice, this list of conditions and the following disclaimer.\000"
+       .ascii "    \000"
+       .ascii " 2. Redistributions in binary form must reproduce the above copyright\000"
+       .ascii "    notice, this list of conditions and the following disclaimer in the\000"
+       .ascii "    documentation and/or other materials provided with the distribution.\000"
+       .ascii "    \000"
+       .ascii " 3. The copyright holder's name must not be used to endorse or promote\000"
+       .ascii "    any products derived from this software without his specific prior\000"
+       .ascii "    written permission.\000"
+       .ascii "    \000"
+       .ascii " This software is provided 'as is' with no express or implied warranties\000"
+       .ascii " of correctness or fitness for purpose.\000"
+       .ascii "    \000"

