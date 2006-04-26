Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWDZRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWDZRmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDZRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:42:02 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:60585 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932318AbWDZRmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:42:01 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] kernel/kthread.c: possible cleanups
Date: Wed, 26 Apr 2006 19:39:22 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060423114022.GJ5010@stusta.de> <200604231537.55205.ioe-lkml@rameria.de> <20060426123111.GA1528@stusta.de>
In-Reply-To: <20060426123111.GA1528@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261939.23535.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wednesday, 26. April 2006 14:31, Adrian Bunk wrote:
> On Sun, Apr 23, 2006 at 03:37:40PM +0200, Ingo Oeser wrote:
> > Could you cleanup the code paths as well?
> > 
> > Now s is always NULL in kthread_stop_sem() and
> > kthread_stop_sem() is degenerated to kthread_stop().
> > So it can be folded into the latter.
> 
> Sounds reasonable, updated patch below.

Acked-by: Ingo Oeser <ioe-lkml@rameria.de>

Beautiful! Making Linux better line by line :-)


Regards

Ingo Oeser
