Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWD0Loa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWD0Loa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWD0Loa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:44:30 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:38623 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964960AbWD0Lo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:44:29 -0400
Date: Thu, 27 Apr 2006 13:43:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 04/16] ehca: userspace support
Message-ID: <20060427114355.GB32127@wohnheim.fh-wedel.de>
References: <4450A176.9000008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A176.9000008@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More minors.

On Thu, 27 April 2006 12:48:22 +0200, Heiko J Schick wrote:
> +
> +	EDEB_EN(7,
> +		"vm_start=%lx vm_end=%lx vm_page_prot=%lx vm_fileoff=%lx "
> +		"address=%lx",
> +		vma->vm_start, vma->vm_end, vma->vm_page_prot, fileoffset,
> +		address);

Gesundheit!  Seriously, I suspect "EDEB_EN" is not the best possible
name to pick.

> +                if (cq->ownpid!=cur_pid) {

Coding style would require spaces around binary operators.

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
