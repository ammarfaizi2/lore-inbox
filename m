Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSD2PQM>; Mon, 29 Apr 2002 11:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSD2PQL>; Mon, 29 Apr 2002 11:16:11 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:50939 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S312498AbSD2PQK>; Mon, 29 Apr 2002 11:16:10 -0400
Date: Mon, 29 Apr 2002 11:14:45 -0400
From: "V. Guruprasad" <prasad@watson.ibm.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: difficulty with symbol export
Message-ID: <20020429111445.B23004@watson.ibm.com>
In-Reply-To: <20020429083514.A21779@watson.ibm.com> <Pine.LNX.4.44.0204290951180.32217-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 2002.04.29, Kai Germaschewski wrote:

> Do you have CONFIG_MODVERSIONS turned on in your kernel config? If so,
> you probably want to save your .config, make distclean and rebuild from 
> scratch - that will likely fix the problem.

Thanks, that solved it. Evidently, a 'make dep' was required which makes
#defines in include/linux/modules/netsyms.ver

thanks,
-p.

------------------------
V. Guruprasad ('prasad'),
http://www.columbia.edu/~vg96
