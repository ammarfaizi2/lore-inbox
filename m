Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTKNROs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTKNROs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:14:48 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:16265 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262770AbTKNROq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:14:46 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: 2 TB partition support
Date: Fri, 14 Nov 2003 18:14:26 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au> <20031112002811.GA18177@tc.pci.uni-heidelberg.de> <16306.35684.471324.582862@wombat.chubb.wattle.id.au>
In-Reply-To: <16306.35684.471324.582862@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141814.26887.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On unpatched 2.4, the limit (depending on your driver) for a single
> block device is either 2TB-1k or 1TB - 512b.
>
> The 2.4 kernel keeps the block device sizes in an unsigned int, in 1k
> units, so the maximum size is (2^32-1)*1k.
>
> I forget which subsystem does it,but one of them tries to keep the
> capacity of a disc in an unsigned int in 512byte units; if you're using
> that subsystem, the macimum size you can use is (2^31-1)*512b
>

Hello Peter,

 thanks for your help. Which driver doest this 2TB or 1TB-maximum blocksize 
size depend on? 
If we could get 2TB-1k, it would be great, since our raid will be 2.1TB and we 
plan to hardware-split it into 300MB+1800MB (hardware ide/scsi-system).

Thanks again, 
	Bernd
