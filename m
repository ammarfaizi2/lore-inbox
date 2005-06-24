Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVFXQ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVFXQ27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVFXQ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:28:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:55434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263036AbVFXQ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:28:53 -0400
Date: Fri, 24 Jun 2005 09:27:14 -0700
From: Greg KH <greg@kroah.com>
To: tvrtko.ursulin@sophos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624162714.GB30598@kroah.com>
References: <OFD982C671.CCDA87F9-ON8025702A.0054FDEB-8025702A.00556118@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD982C671.CCDA87F9-ON8025702A.0054FDEB-8025702A.00556118@sophos.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:32:34PM +0100, tvrtko.ursulin@sophos.com wrote:
> On 24/06/2005 16:23:11 Greg KH wrote:
> 
> >> ndevfs: creating file '0000:02' with major 0 and minor 0
> >
> >Hm, that is odd.  That shouldn't happen.
> >
> >Wait, I think it was due to where you put the class hooks, try it
> >against Linus's latest tree, it will work better there (in fact, I don't
> >know if it would work properly in 2.6.12 due to the class driver core
> >changes.)
> >
> >Could you try that and let me know if it still has issues?
> 
> It was me incorrectly fixing the rejects. If I had looked at it more 
> carefully I would have got it right the first time. Anyway, I moved the 
> relevant ndevfs_create in the right 'if' block and now everything is fine. 
> Am I still using 2.6.12 btw.

Great, thanks for validating this.

> Sorry for not letting you know that earlier, I was waiting for my post to 
> show up so that I can reply to myself.

Your message was too big and was probably rejected by the list.

thanks,

greg k-h
