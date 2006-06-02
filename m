Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWFBAYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFBAYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWFBAYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:24:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbWFBAYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:24:08 -0400
Date: Thu, 1 Jun 2006 17:28:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601172816.78f8839b.akpm@osdl.org>
In-Reply-To: <986ed62e0606011707m11f82b7i712452236ea06cfb@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
	<986ed62e0606011532kdeba801l57c1867c54b2be87@mail.gmail.com>
	<20060601155250.7dbcc6ef.akpm@osdl.org>
	<986ed62e0606011707m11f82b7i712452236ea06cfb@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 17:07:29 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> > Please send `grep SCSI .config'.
> 
> Ok, here it is.
> 
> # CONFIG_SCSI_TGT is not set
> CONFIG_SCSI_SRP=m

yup, that's the problem, thanks.
