Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJIAQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJIAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:16:51 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:63889 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261838AbTJIAQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:16:47 -0400
Date: Thu, 9 Oct 2003 02:16:35 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jai <jai@linknet.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb problem
Message-ID: <20031009001635.GA24323@vana.vc.cvut.cz>
References: <007701c38df5$7639a8a0$1400a8c0@lan.sky.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007701c38df5$7639a8a0$1400a8c0@lan.sky.net.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 09:39:48AM +1000, Jai wrote:
>  Hi all,
> 
> I'm running kernel-2.4.20, I have enabled frame buffer support for matrox
> G550 in the kernel, but get these messages on boot:
> 
> matroxset: Matrox G550 detected
> matroxset: MTRR's turned on
> matroxfb: cannot set required perameters
> 
> and of course /dev/fb0 and fb1 are not available.
> 
> I have also tried it with kernel-2.4.22, I believe I have seen this working
> before but I can't seem remember what it is i havn't done.
> Has anyone got any light to shed on this.
> 
> Thanks for your time. Please CC me with any replies.

Your .config ? I'd say that you disabled support for some color depth, yet
you asked for this depth with 'video=XXX' parameter.
							Petr

