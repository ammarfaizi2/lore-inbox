Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUDBAaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUDBAaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:30:16 -0500
Received: from CPE-144-136-178-58.sa.bigpond.net.au ([144.136.178.58]:6418
	"EHLO bubble.modra.org") by vger.kernel.org with ESMTP
	id S262971AbUDBAaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:30:12 -0500
Date: Fri, 2 Apr 2004 10:00:09 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Janis Johnson <janis187@us.ibm.com>
Cc: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402003009.GD6645@bubble.modra.org>
Mail-Followup-To: Janis Johnson <janis187@us.ibm.com>,
	Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>,
	gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
	schwidefsky@de.ibm.com, ak@suse.de
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401211348.GA5739@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401211348.GA5739@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 01:13:48PM -0800, Janis Johnson wrote:
> We saw lots of parallel build problems when using a 2.6 kernel on
> an older distribution.  The problems went away when we used 'make'
> built with a new version of glibc.

Yes, that was a different bug, powerpc glibc specific.
http://sources.redhat.com/ml/libc-alpha/2004-02/msg00037.html

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
