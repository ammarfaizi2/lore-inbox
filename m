Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUDAVmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbUDAVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:41:47 -0500
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:62916 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263281AbUDAVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:41:32 -0500
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200404012141.XAA23846@faui1d.informatik.uni-erlangen.de>
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
To: janis187@us.ibm.com (Janis Johnson)
Date: Thu, 1 Apr 2004 23:41:28 +0200 (CEST)
Cc: weigand@i1.informatik.uni-erlangen.de (Ulrich Weigand), gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de
In-Reply-To: <20040401211348.GA5739@us.ibm.com> from "Janis Johnson" at Apr 01, 2004 01:13:48 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janis Johnson wrote:
> On Thu, Apr 01, 2004 at 09:28:20PM +0200, Ulrich Weigand wrote:
> > Hello,
> > 
> > I'm seeing a race condition on Linux 2.6 that rather reproducibly
> > causes GCC bootstrap failures on current mainline.
> 
> We saw lots of parallel build problems when using a 2.6 kernel on
> an older distribution.  The problems went away when we used 'make'
> built with a new version of glibc.

I'm using pretty recent versions of everything: a glibc 2.3.3 as of
2004-03-11, binutils 2.15.90.0.1, make 3.80, and a 2.6.4+ kernel.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
