Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbUDAV3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDAV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:29:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63176 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263186AbUDAVP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:15:58 -0500
Date: Thu, 1 Apr 2004 13:13:48 -0800
From: Janis Johnson <janis187@us.ibm.com>
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040401211348.GA5739@us.ibm.com>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 09:28:20PM +0200, Ulrich Weigand wrote:
> Hello,
> 
> I'm seeing a race condition on Linux 2.6 that rather reproducibly
> causes GCC bootstrap failures on current mainline.

We saw lots of parallel build problems when using a 2.6 kernel on
an older distribution.  The problems went away when we used 'make'
built with a new version of glibc.

Janis
