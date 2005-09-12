Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVILAJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVILAJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 20:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVILAJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 20:09:59 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:12858 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751090AbVILAJ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 20:09:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FwfjGrEJxyR9pBWHRMluqK8sVsNSR+q0Fq/D/boXYWYXCBf02JqlL1Leho/zpY8Wy52J36Sa3H1lMNEMOZYor7euikvCLhh4SdrOnbURPPpcL0Q+9YZbQUpfXDoYoodrIxIMeQVisNA38Mk6O7ZkQ0oSxx1FtStwxA702+6ab/Q=
Message-ID: <6bffcb0e050911170935fbd861@mail.gmail.com>
Date: Mon, 12 Sep 2005 02:09:53 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: oops plugsched, spa_ws, scsi, sata, ata_piix, threading 2.6.13-mm2
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4324B929.7090001@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4323896F.5050703@bigpond.net.au>
	 <6bffcb0e05091113576925a8e9@mail.gmail.com>
	 <4324B929.7090001@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
> Could you please confirm that this only occurs with cpusched=spa_ws and
> not with any of the other schedulers?  In particular, if you could try
> it for ingosched, staircase and spa_no_frills I would appreciate it.

It must be scsi problem. I do some tests (boot, reboot) with all
schedulers (5 times for every scheduler) and the same oops appeared
with staircase - but only once.

Regards,
Michal Piotrowski
