Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGVKvS>; Mon, 22 Jul 2002 06:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSGVKvS>; Mon, 22 Jul 2002 06:51:18 -0400
Received: from verein.lst.de ([212.34.181.86]:10762 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S316681AbSGVKvR>;
	Mon, 22 Jul 2002 06:51:17 -0400
Date: Mon, 22 Jul 2002 12:53:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
Message-ID: <20020722125347.B16685@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, martin@dalecki.de,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE17F.3040905@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3BE17F.3040905@evision.ag>; from dalecki@evision.ag on Mon, Jul 22, 2002 at 12:42:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
> This is making the sysctl code acutally be written in C.
> It wasn't mostly due to georgeous ommitted size array "forward
> declarations". As a side effect it makes the table structure easier to
> deduce.

Please don't remove the trailing commas in the enums.  they make adding
to them much easier and are allowed by gcc (and maybe C99, I'm not
sure).

