Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVCBQHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVCBQHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCBQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:07:48 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:64370 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262343AbVCBQHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:07:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tjTcFwULCesLBZwkRI49QS/dsKskz3Dv2McDI6WDCHqr7oM7bA3GQ+th+DoV30GCK5KnPGShqbpnDklljSVHoPmcS1xZkzlTdiVyiGM/Vrmxe0HppfapwZ6jeAe85wQieJsDSoN3Xcub3qYCrLsjWFQRGgvkNqGABiQAC4Z9L+o=
Message-ID: <58cb370e05030208077189e7@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:07:36 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <42255582.4050204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083809.63BF53E6@htj.dyndns.org>
	 <58cb370e05022407587e86f8ad@mail.gmail.com>
	 <20050227064922.GA27728@htj.dyndns.org>
	 <58cb370e050301063069799c75@mail.gmail.com>
	 <42255582.4050204@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 00:56:18 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > If somebody implements SG_IO ioctl and SCSI command pass-through
> > from libata for IDE driver (and add possibility for discrete taskfiles), we can
> > just deprecate HDIO_DRIVE_TASKFILE, forget about it and some time later
> > remove this FPOS.
> 
> Can you explain what you mean by "add possibility for discrete taskfiles"?

I mean flagged taskfiles.
