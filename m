Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTH2SHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTH2SHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:07:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:25874
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261884AbTH2SGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:06:22 -0400
Date: Fri, 29 Aug 2003 11:06:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030829180623.GB27023@matchmail.com>
Mail-Followup-To: Shantanu Goel <sgoel01@yahoo.com>,
	Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org
References: <20030829145749.GA709@wind.cocodriloo.com> <20030829175544.84979.qmail@web12803.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829175544.84979.qmail@web12803.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:55:44AM -0700, Shantanu Goel wrote:
> I am not very knowledgeable about micro-optimizations.
>  I'll take your word for it. ;-)  What interests me
> more is whether others notice any performance
> improvement under swapout with this patch given that
> is on the order of milliseconds.

But have you compared your patch with the VM patches in -aa?  Will your
patch apply on -aa and make improvements there too?

In other words: Why would I want to use this patch when I could use -aa?

