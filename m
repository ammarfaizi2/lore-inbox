Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWIADCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWIADCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWIADCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:02:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:26781 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750819AbWIADCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:02:47 -0400
X-Sasl-enc: FirVqrsVQwv2d5a8YzEwlG0i3miptMMw7jHngZt5hr4b 1157079765
Date: Fri, 1 Sep 2006 11:02:34 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 09/22][RFC] Unionfs: File operations
In-Reply-To: <20060901014818.GJ5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.64.0609011101020.3811@raven.themaw.net>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014818.GJ5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Josef Sipek wrote:

> +	if (err < 0)
> +		goto out;
> +	if (err != file->f_pos) {
> +		file->f_pos = err;
> +		// ION maybe this?
> +		//      file->f_pos = hidden_file->f_pos;

Do you really want to keep this comment, perhaps it's time to decide?

Ian

