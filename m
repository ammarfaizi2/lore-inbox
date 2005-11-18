Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbVKRUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbVKRUvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbVKRUvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:51:43 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:39436 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161172AbVKRUvn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:51:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7IDJWXYCuwydX4pXIrelTejb1ryUONZNbxIoaAM7ZXb272QU0NLs6k+wSFkAhG93h+A8AsctdcgWEtCUjkwBzcR/Nb5wvvJhYSHuss2qLZkS1Hs9wkx48TqBDO7CQpsLrKtFMMKppWUQg7Zz5hcVN+FOZbOaKwzigmKyxRC484=
Message-ID: <58cb370e0511181251q5cb45eacl39fe4999575e47df@mail.gmail.com>
Date: Fri, 18 Nov 2005 21:51:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Laurent riffard <laurent.riffard@free.fr>
Subject: Re: [patch] remove ide_driver_t.owner field
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>
In-Reply-To: <20051026093816.661471000@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026093816.661471000@antares.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Laurent riffard <laurent.riffard@free.fr> wrote:
> The structure ide_driver_t have a .owner field which is a duplicate
> of .gendriver.owner field (.gen_driver is a struct device_driver).
>
> This patch remove ide_driver_t's owner field.
>
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

applied
