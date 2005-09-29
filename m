Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVI2H1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVI2H1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVI2H1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:27:39 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:15347 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932147AbVI2H1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:27:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuLUqvrj9uS16rsd4lBX2QtJ4mkXYuPQZGXi+61vvtiCfKm+Pjpr8HiPKTpgJBflipm552jj1WVRNcXE4cjTm0fnab3WNGLQyukUSW+FO61uP2ruFjZRWDJwCv46+p3gatb8Oy+WlkA+nrtFdh0JvKe2j7Z17awudxTE5Hy7yB0=
Message-ID: <58cb370e0509290027404f5224@mail.gmail.com>
Date: Thu, 29 Sep 2005 09:27:37 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Cc: Daniel Drake <dsd@gentoo.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Grzegorz Kulewski <kangur@polcom.net> wrote:
> On Wed, 28 Sep 2005, Daniel Drake wrote:
>
> > This entry adds needless complication to the driver as it requires the use of
> > global variables to be passed into via_get_info(), making things quite ugly
> > when we try and make this driver support multiple controllers simultaneously.
> >
> > This patch removes /proc/via for simplicity.
>
> Is similar data available from sysfs?
>
> As a user of this controller, I think that if it is not then this patch
> should be changed to export it or should be dropped. The data from that
> file is really helpfull in debugging problems (for example related to bad
> cables or breaking disks/cdroms).

Could you please give some details (which data is useful)?

Bartlomiej
