Return-Path: <linux-kernel-owner+w=401wt.eu-S932608AbXASPqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbXASPqe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbXASPqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:46:34 -0500
Received: from homer.mvista.com ([63.81.120.155]:17491 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932477AbXASPqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:46:33 -0500
Message-ID: <45B0E7D7.3020608@ru.mvista.com>
Date: Fri, 19 Jan 2007 18:46:31 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/19] ide: update MAINTAINERS entry
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain> <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: update MAINTAINERS entry

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  MAINTAINERS |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

> Index: my-2.6/MAINTAINERS
> ===================================================================
> --- my-2.6.orig/MAINTAINERS
> +++ my-2.6/MAINTAINERS
> @@ -1585,12 +1585,11 @@ M:	ipslinux@adaptec.com
>  W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
>  S:	Supported 
>  
> -IDE DRIVER [GENERAL]
> +IDE SUBSYSTEM
>  P:	Bartlomiej Zolnierkiewicz
> -M:	B.Zolnierkiewicz@elka.pw.edu.pl
> -L:	linux-kernel@vger.kernel.org
> +M:	bzolnier@gmail.com
>  L:	linux-ide@vger.kernel.org
> -T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
> +T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
>  S:	Maintained

    BTW, if I'm (or somebody else) sending patches with IDE driver *fixes*, 
should these be against that quilt tree (containing largely reworked IDE 
code), against fresh Linus' tree (or some recent -rc), or against recent -mm tree?

WBR, Sergei
