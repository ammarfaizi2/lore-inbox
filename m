Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319257AbSHNRgs>; Wed, 14 Aug 2002 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319258AbSHNRgs>; Wed, 14 Aug 2002 13:36:48 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38929 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319257AbSHNRgr>; Wed, 14 Aug 2002 13:36:47 -0400
Date: Wed, 14 Aug 2002 18:40:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac1 does not compile
Message-ID: <20020814184040.A21382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
	linux-kernel@vger.kernel.org
References: <3D5A9451.C240C27A@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5A9451.C240C27A@wanadoo.fr>; from jean-luc.coulon@wanadoo.fr on Wed, Aug 14, 2002 at 07:33:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 07:33:05PM +0200, Jean-Luc Coulon wrote:
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
> -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> -DKBUILD_BASENAME=swap_state  -c -o swap_state.o swap_state.c
> swap_state.c:155: macro `PAGE_BUG' used without args

make that a plain BUG() - no idea what drove alan into that..

