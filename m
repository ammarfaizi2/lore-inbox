Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269592AbUICJp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269592AbUICJp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269627AbUICJk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:40:56 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64918 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269602AbUICJk2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:40:28 -0400
X-Envelope-From: kraxel@bytesex.org
To: Frederik Deweerdt <frederik.deweerdt@laposte.net>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] v4l: bttv driver update.
References: <20040831152405.GA15658@bytesex>
	<20040901073206.GA21887@gilgamesh.home.res>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 02 Sep 2004 09:39:00 +0200
In-Reply-To: <20040901073206.GA21887@gilgamesh.home.res>
Message-ID: <87acw9i0h7.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt <frederik.deweerdt@laposte.net> writes:

> Le Tue, Aug 31, 2004 at 05:24:05PM +0200, Gerd Knorr écrivit:
> >   Hi,
> [...] 
> > -	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),NULL);
> > +	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),0);
> 
> Sorry if it's irrelevant here, but I though there had been a 
> campaign advocating "NULL instead of 0 in the Linux Kernel"?
> Ref: http://lkml.org/lkml/2004/7/8/9

Oops, that one slipped through when merging the 2.6.9-rc1 changes into
my tree.  Chunk can be dropped.

  Gerd

-- 
return -ENOSIG;
