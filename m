Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVJMWwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVJMWwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVJMWwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:52:34 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:57369 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964876AbVJMWwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:52:33 -0400
Message-ID: <434EE534.6010500@gentoo.org>
Date: Thu, 13 Oct 2005 23:52:36 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
References: <43146CC3.4010005@gentoo.org>  <58cb370e05083008121f2eb783@mail.gmail.com>  <43179CC9.8090608@gentoo.org>  <58cb370e050927062049be32f8@mail.gmail.com>  <433B16BD.7040409@gentoo.org>  <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net> <58cb370e0509290027404f5224@mail.gmail.com> <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Grzegorz Kulewski wrote:
>>> As a user of this controller, I think that if it is not then this patch
>>> should be changed to export it or should be dropped. The data from that
>>> file is really helpfull in debugging problems (for example related to 
>>> bad
>>> cables or breaking disks/cdroms).

Per Bart's suggestion, I've created a user-space app which shows identical 
data (and doesn't even rely on the via82cxxx IDE driver).

http://www.reactivated.net/software/viaideinfo/

So, I think we should be clear to drop /proc/ide/via now.

Daniel
