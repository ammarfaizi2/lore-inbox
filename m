Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUJGSz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUJGSz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUJGSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:55:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267806AbUJGSvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:51:07 -0400
Date: Thu, 7 Oct 2004 13:53:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
Message-ID: <20041007165316.GA15186@logos.cnet>
References: <200410071318.21091.mbuesch@freenet.de> <20041007151518.GA14614@logos.cnet> <200410071917.40896.mbuesch@freenet.de> <20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp> <20041007164221.GD14614@logos.cnet> <x63c0qbc84@gzp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x63c0qbc84@gzp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:43:39PM +0200, Gabor Z. Papp wrote:
> * Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> 
> | > There is really no way to run 2.4 without swap?
> | 
> | Nope. Any kernel can't. The thing is the system overcommits 
> | memory (it allows applications to allocate more memory than the system 
> | is able to handle).
> 
> Okay, then whats the required minimum swap size that needed to avoid
> such crashes?
> 
> In the case when the system is in the ram, quite funny to allocate a
> swap file on the ramdisk anyway...

It depends on how much memory you have an idea of the workload
you have is going to use.

How much memory do you have? Try 128MB for a test.

Also investigate swap-over-nfs/swap-over-nbd.


