Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbUJ1Aej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUJ1Aej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUJ1AcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:32:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262687AbUJ1Abb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:31:31 -0400
Date: Thu, 28 Oct 2004 01:31:29 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Lei Yang <lya755@ece.northwestern.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loopback on block device
Message-ID: <20041028003129.GL24336@parcelfarce.linux.theplanet.co.uk>
References: <417FE703.3070608@ece.northwestern.edu> <417FE922.7080009@ece.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FE922.7080009@ece.northwestern.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 01:29:54PM -0500, Lei Yang wrote:
> >Here is a question for loopback device. As far as I understand,  the 
> >loopback device is used to mount files as if they were block devices.
> >
> >Then Why I could do "losetup -e XOR /dev/loop0 /dev/ram0" ? Notice 
> >that ram0 is not mounted anywhere and does not have a filesystem on 
> >it. I've tried that command and there seems to be no error. I got 
> >confused and looked into loop.c, it seems to me that a loopback device 
> >should be associated with a "backing file", why would it work on a 
> >block device anyway?

Because block device is a file.
