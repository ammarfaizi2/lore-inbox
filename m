Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVEKFkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVEKFkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVEKFkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:40:19 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:31167 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261895AbVEKFkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:40:14 -0400
Date: Tue, 10 May 2005 22:40:13 -0700
From: Greg KH <gregkh@suse.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511054013.GE8287@suse.de>
References: <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain> <20050511000519.GA17762@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511000519.GA17762@wonderland.linux.it>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 02:05:19AM +0200, Marco d'Itri wrote:
> On May 11, Erik van Konijnenburg <ekonijn@xs4all.nl> wrote:
> 
> Thank you for your patch! I have two comments:
> - the blacklist should be used only if modprobe is run by the kernel
>   (check $SEQNUM?)

No, it should be used only if you are running modprobe on an alias.

thanks,

greg k-h
