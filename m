Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263654AbUDYWPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUDYWPe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUDYWPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 18:15:34 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:15376 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263654AbUDYWPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 18:15:33 -0400
Date: Mon, 26 Apr 2004 00:15:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Remi Colinet <remi.colinet@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040425221528.GB3040@pclin040.win.tue.nl>
References: <4082819E.10106@free.fr> <20040420074650.GA3040@pclin040.win.tue.nl> <20040420143634.GA12132@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420143634.GA12132@bitwizard.nl>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 04:36:35PM +0200, Rogier Wolff wrote:
...
> then there is a problem and I can understand "Busy".  But if the new
> scheme is: 
> 
> 	<hda1> swap 1G  
> 	<hda2> root 19G   (active)
>       <hda3> data 20G   <unformatted>
> 
> then I don't understand the reason for refusing the rereadpt request.
> 
> Anybody want to code this up?

The answer is always the same: it exists and is called partx.

Maybe you want to move part of its functionality into the kernel,
but there is no good reason.
