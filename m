Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbUDGQYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUDGQYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:24:44 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:9655 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263729AbUDGQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:24:32 -0400
Date: Wed, 7 Apr 2004 10:24:29 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic when adding root=/LABEL=/  in grub.conf - newbie
Message-ID: <20040407162429.GH5107@schnapps.adilger.int>
Mail-Followup-To: sting sting <zstingx@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <Sea2-F121U1x4ykaaEv0001bc59@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F121U1x4ykaaEv0001bc59@hotmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 07, 2004  16:37 +0300, sting sting wrote:
> when I add the following in grub.conf (to the option of choosing to load 
> this kernel)
> 
> root=/LABEL=/
> 
> I get the the following panic message:
> VFS: cannot open root device = "LABEL=/" or 00:00
> Please append a correct "root= "  boot option.
> Kernel panic : VFS: unable to mount root fs on 00:00

Instead, use the correct format, otherwise (as errors say, a device "/LABEL="
cannot be found:

root=LABEL=/

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

