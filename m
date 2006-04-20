Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWDTQ0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWDTQ0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDTQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:26:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:7565 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751122AbWDTQ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:26:44 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.17-rc2
Date: Thu, 20 Apr 2006 18:24:26 +0200
User-Agent: KMail/1.9.1
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604201824.27616.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 19. April 2006 20:44, Linus Torvalds wrote:
> Or, rather than just a boring socket->socket forwarding, you could, for 
> example, forward data that comes from a MPEG-4 hardware encoder, and tee() 
> it to duplicate the stream, and write one of the streams to disk, and the 
> other one to a socket for a real-time broadcast. Again, all without 
> actually physically copying it around in memory.

Yes! That's what I've been after for some time now.

Thanks everyone.


Regards

Ingo Oeser
