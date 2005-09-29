Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVI2H0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVI2H0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVI2H0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:26:23 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:12514 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932146AbVI2H0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:26:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L3vVjJ/jkgFkzvxv1eTJywNy/0i27VbzsXnB6zvQ4XFaZxzw9c/Tp87mkVIM/7tpZT9EbodNwBpv5wOZI5uFa+7y6+JgDm2KmlUdl3eb24B9adx8xtlTBhO+ELetFNdeICNkWlJDBs6e7wZT3Dg82wDejbV4z3XO8y5kom29X+s=
Message-ID: <58cb370e0509290026655a7bb1@mail.gmail.com>
Date: Thu, 29 Sep 2005 09:26:17 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/ide/via entry
Cc: Al Viro <viro@ftp.linux.org.uk>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <433B2081.9050607@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B16BD.7040409@gentoo.org> <20050928223718.GB7992@ftp.linux.org.uk>
	 <433B2081.9050607@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/05, Daniel Drake <dsd@gentoo.org> wrote:
> Hi Al,
>
> (btw, original subject was wrong, I actually meant /proc/ide/via)
>
> Al Viro wrote:
> > Care to explain
> >       * where to get equivalent information?
>
> I don't think there is anywhere else that provides the whole range, but I do
> question the usefulness of most of it :)

Exactly, all the important information is available through other sources
(dmesg, lspci and of course /proc/ide/hd?/*) and configuration of timing
registers etc. shouldn't be of user concern (and it is available from PCI
configuration space so code to parse it can be easily moved to user-space).

Bartlomiej
