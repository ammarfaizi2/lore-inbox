Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbSIYVhT>; Wed, 25 Sep 2002 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSIYVhT>; Wed, 25 Sep 2002 17:37:19 -0400
Received: from postino2.roma1.infn.it ([141.108.26.25]:53689 "EHLO
	postino2.roma1.infn.it") by vger.kernel.org with ESMTP
	id <S262108AbSIYVhS>; Wed, 25 Sep 2002 17:37:18 -0400
Date: Wed, 25 Sep 2002 23:42:31 +0200 (CEST)
From: "davide.rossetti" <Davide.Rossetti@roma1.infn.it>
Reply-To: davide.rossetti@roma1.infn.it
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <E17ttkV-0003id-00@starship>
Message-ID: <Pine.LNX.4.44.0209252338370.2766-100000@ronin.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (postino2.roma1.infn.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Daniel Phillips wrote:

> On Tuesday 24 September 2002 18:54, Dave Olien wrote:
> > According to the Documentation/DMA-mapping.txt file, the new
> > DMA mapping interfaces should allow all PCI transfers to use 32-bit DMA
> > addresses. Controllers on the PCI bus should never need to use DAC
> > PCI transfers.  Based on this, writel() should work even on ia64.
> 
> A totally disgusting idea: MMX/x87 are also capable of transferring 8
> bytes in one instruction on ia32.

to the north bridge. but then it's a bridge matter how to translate that
access on the PCI side... I guess.
regards

-- 
______/ Rossetti Davide   INFN - Roma I - APE group \______________
 pho +390649914507/412   web: http://apegate.roma1.infn.it/~rossetti
 fax +390649914423     email: davide.rossetti@roma1.infn.it        

