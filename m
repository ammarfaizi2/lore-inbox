Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWAKNyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWAKNyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWAKNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:54:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:63143 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751623AbWAKNyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:54:46 -0500
From: Andi Kleen <ak@suse.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Wed, 11 Jan 2006 14:51:33 +0100
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <200601111417.19234.ak@suse.de> <43C50B6D.6090608@gmail.com>
In-Reply-To: <43C50B6D.6090608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111451.34178.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 14:43, Antonino A. Daplas wrote:
> Andi Kleen wrote:
> > On Wednesday 11 January 2006 14:05, Antonino A. Daplas wrote:
> >> Andi Kleen wrote:
> >>> On Wednesday 11 January 2006 13:24, Antonino A. Daplas wrote:
> >>>
> >>>> In the VGA console, all buffers, including scrollback is in video RAM, but
> >>>> the size is fixed and is very small.
> >>> I wonder if that can be fixed.
> >> It can be done, but it will affect VGA console performance.
> > 
> > By how much? As long as it still scrolls reasonably fast it would be ok for me.
> 
> Each character will need to be written twice, one to VGA RAM and another to
> the shadow/scrollback buffer in system RAM.

That should be basically unnoticeable. 

> It would still be reasonably fast. 
> 
> Perhaps I can implement this for vgacon.

Please do. And increase the default scrollback please or make it a CONFIG.

Thanks,
-Andi
