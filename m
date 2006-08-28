Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWH1Vvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWH1Vvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWH1Vvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:51:37 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44757 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932217AbWH1Vvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:51:35 -0400
Date: Mon, 28 Aug 2006 17:49:01 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] Relative atime - userspace
Message-ID: <20060828214901.GA24374@filer.fsl.cs.sunysb.edu>
References: <20060825235215.820563000@linux.intel.com> <20060825235619.GB25003@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825235619.GB25003@goober>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 04:56:19PM -0700, Valerie Henson wrote:
>  #define MS_VERBOSE	0x8000	/* 32768 */
...
> +#define MS_RELATIME   0x200000	/* 200000: Update access times relative

Just a small thing... 0x200000 != 200000

Josef "Jeff" Sipek.

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
