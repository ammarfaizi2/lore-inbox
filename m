Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVBCAYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVBCAYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVBCAWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:22:45 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:22997 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262395AbVBCAUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:20:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dwpSc6mbbJM/uNmjpW9L2O+crE2ld9MnyQj0R1qB3Ws95Whp2tSMDNsNuIIfgQ06olGXznb4227bBQAXlVRnsspoC9sj9yGSAWWeek+blXu8j8LLPEYuFqdUBYKDUfAzz0v97YyML02rd2LitTJBtC0wSDC9ww0bUeIc4QlKV88=
Message-ID: <58cb370e050202162041f9b92@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:20:15 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 04/29] ide: cleanup piix
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024611.GE621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024611.GE621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:46:11 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 04_ide_cleanup_piix.patch
> >
> >       In drivers/ide/pci/piix.[hc], init_setup_piix() is defined and
> >       used but only one init_setup function is defined and no
> >       demultiplexing is done using init_setup callback.  As other
> >       drivers call ide_setup_pci_device() directly in such cases,
> >       this patch removes init_setup_piix() and makes piix_init_one()
> >       call ide_setup_pci_device() directly.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
