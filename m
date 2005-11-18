Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbVKRUjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbVKRUjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbVKRUjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:39:33 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:41860 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161183AbVKRUjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lZ/tkvT39q+bi/bb0Xdz8FZqj0WNpImNVTsUS8UcJcS48+FXaozAEcrQCzh2w+Mx3+rLFoCId/ny+kENQAZbb9vOdMAc6V8EMNiIB0NWTXNc9Lfy89D2Nn3JMpZZgG6U5oEAWGrX97xjUNU0tA2E+Pe33V1THoOobV8JD5mECdM=
Message-ID: <58cb370e0511181239n369c9a88hd9292055e4d03d92@mail.gmail.com>
Date: Fri, 18 Nov 2005 21:39:29 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Cc: Grzegorz Kulewski <kangur@polcom.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <434EE534.6010500@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B16BD.7040409@gentoo.org>
	 <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
	 <58cb370e0509290027404f5224@mail.gmail.com>
	 <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
	 <434EE534.6010500@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Daniel Drake <dsd@gentoo.org> wrote:
> Hi,
>
> Grzegorz Kulewski wrote:
> >>> As a user of this controller, I think that if it is not then this patch
> >>> should be changed to export it or should be dropped. The data from that
> >>> file is really helpfull in debugging problems (for example related to
> >>> bad
> >>> cables or breaking disks/cdroms).
>
> Per Bart's suggestion, I've created a user-space app which shows identical
> data (and doesn't even rely on the via82cxxx IDE driver).
>
> http://www.reactivated.net/software/viaideinfo/
>
> So, I think we should be clear to drop /proc/ide/via now.

patch applied, thanks for working on this
