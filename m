Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDEXAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUDEXAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:00:01 -0400
Received: from p02m172.mxlogic.net ([216.173.230.172]:56029 "HELO
	p02m172.mxlogic.net") by vger.kernel.org with SMTP id S262974AbUDEW76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:59:58 -0400
Message-ID: <4071D11B.1FEFD20A@amis.com>
Date: Mon, 05 Apr 2004 15:35:23 -0600
From: Eric Whiting <ewhiting@amis.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MX-Spam: exempt
X-MX-MAIL-FROM: <ewhiting@amis.com>
X-MX-SOURCE-IP: [207.141.5.253]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Apr 05, 2004 at 10:36:58AM -0600, Eric Whiting wrote:
> > The 4G/4G patch is still useful for me -- although 64bit linux (x86_64) is the
> > best 'real' long-term solution to large memory jobs.
> 
> what's your primary limitation? physical memory or virtual address
> space? if it's physical memory go with 2.6-aa and it'll work fine up to
> 32G boxes included at full cpu performance.

4G of virtual address is what we need. Virtual address space is why the -mmX
4G/4G patches are useful. In this application it is single processes (usually
running one at a time) that need more than 3G of RAM. 
 
> if it's virtual address space and you've not much more than 4G of ram
> 3.5:1.5 usually works fine, and againt you'll run at full cpu
> performance.

3.5:1.5 appears to be a 2.4.x kernel patch only right?
