Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbVBFABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbVBFABQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272025AbVBFABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:01:15 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:64359 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264131AbVBFABI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:01:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HLiOZAVsJ/y2jG6eEJV+gSNUQ+0gSV0NO10IAEH26vCrGw0MErtT+wZ31NlxP/0CJ4IRBmgSRPqq+nE0rYnCTncJZx/CRZ9+nss8ar7jrm4RM+9f9X/z6QhoGBavrLofaP/l2Gt+TQeaNcg8dK8LxZrOf2rixYHhVH/YNsz7o5s=
Message-ID: <58cb370e050205160143c11876@mail.gmail.com>
Date: Sun, 6 Feb 2005 01:01:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 01/14] ide_pci: Remove lousy macros from aec62xx.
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071317.A06E013264C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071317.A06E013264C@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:17 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 01_ide_pci_aec62xx_cleanup.patch
> 
>         Removes SPLIT_BYTE, MAKE_WORD and BUSCLOCK macros which are
>         just better off directly coded from ide/pci/aec62xx driver.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied but I left BUSCLOCK() alone for now
