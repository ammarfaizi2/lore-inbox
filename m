Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290466AbSAYAjq>; Thu, 24 Jan 2002 19:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290468AbSAYAjh>; Thu, 24 Jan 2002 19:39:37 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:48814 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290466AbSAYAj0>; Thu, 24 Jan 2002 19:39:26 -0500
Date: Thu, 24 Jan 2002 19:39:25 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: jt@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trigraph warning cleanup for wavelan_cs in 2.5.3-pre5
Message-ID: <20020124193925.I4459@redhat.com>
In-Reply-To: <20020124162233.C12682@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020124162233.C12682@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Thu, Jan 24, 2002 at 04:22:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 04:22:33PM -0800, Jean Tourrilhes wrote:
> 	Hi Linus,
> 
> 	This is a trivial patch that fixes some trigraph warning and
> was a leftover of the driver backport. I think adding that to your
> tree would please Jeff.

Doesn't -Wno-trigraphs in the top level makefile avoid this?  Or is the 
file in question not being complied with the correct flags?

		-ben


