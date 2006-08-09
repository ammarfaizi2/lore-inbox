Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWHIOVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWHIOVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWHIOVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:21:07 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:5938 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750866AbWHIOVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:21:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i1Rmop7TrMUDC2BIao6OczZHHR6e8L1lct+vr4ja0rk3ddeU/x9uSbJd/NDFz/xEJZLcyFYKt3VGJjpssW92L5uaLnhvlOorzJzYbzfKNBgtRXayNSrucoeZXDvhLoiHG81SHYIjnz/fmSbUg9zN4ejGLEVjSecGHh9tGAFDC3o=
Message-ID: <6bffcb0e0608090720g2ac739desd25a77e3c98ef268@mail.gmail.com>
Date: Wed, 9 Aug 2006 16:20:57 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
>
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
>

When I want to halt system I type "init 0", but it stops on

Halting system...
Synchronizing SCSI cache for disk sda
Shutdown: hda

Problem appears on 2.6.18-rc3-mm*. I guess that this is an IDE or ACPI bug.
I'll revert IDE and ACPI patches. If it won't help, I'll do binary search.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
