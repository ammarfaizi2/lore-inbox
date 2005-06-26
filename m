Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFZQRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFZQRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVFZQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:17:47 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:31374 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261350AbVFZQRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:17:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E6jkilswC2Kv1ELLKoyb7yeQgSQ+ykScno6n0G153pbNJ7JLjcrl2TjyefnL0mcapZ8TEP4+tY6TULXh3Jdi/f0FijEvK7DYsWhLzb9QDNJrAZNcut+xD1rsPIZxzy/QzR+L7Bl5e84WBSVe3NBXIF9RcNS5ZZKD7uEnPWUTIXE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mario Lang <mlang@delysid.org>
Subject: Re: GDTH error on 2.6
Date: Sun, 26 Jun 2005 20:23:41 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <877jgkndrf.fsf@lexx.delysid.org>
In-Reply-To: <877jgkndrf.fsf@lexx.delysid.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262023.41683.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 16:24, Mario Lang wrote:
> After upgrading an existing system from 2.4 to 2.6, we noticed
> a strange error message from the DGTH module:
> 
> GDT-HA 0: Unknown SCSI command 0x4d to cache service !
> SCSI error : <0 0 0 0> return code = 0x50000
> 
> Which repeats itself over and over again.
> 
> This is with version 3.04 of gdth.c from
> 2.6.9-5.0.5.ELsmp SMP 686 REGPARM 4KSTACKS gcc-3.4

Does it happen with 2.6.12?

> We've already done a controller BIOS upgrade, but the problem did
> not go away.

