Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVI1WhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVI1WhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVI1WhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:37:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43416 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751010AbVI1WhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:37:23 -0400
Date: Wed, 28 Sep 2005 23:37:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Message-ID: <20050928223718.GB7992@ftp.linux.org.uk>
References: <43146CC3.4010005@gentoo.org> <58cb370e05083008121f2eb783@mail.gmail.com> <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <433B16BD.7040409@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433B16BD.7040409@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 11:18:37PM +0100, Daniel Drake wrote:
> This entry adds needless complication to the driver as it requires the use 
> of
> global variables to be passed into via_get_info(), making things quite ugly
> when we try and make this driver support multiple controllers 
> simultaneously.
> 
> This patch removes /proc/via for simplicity.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Care to explain
	* where to get equivalent information?
	* what hardware setup has more than one of those controllers?
