Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbSJPOmr>; Wed, 16 Oct 2002 10:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbSJPOmr>; Wed, 16 Oct 2002 10:42:47 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8717 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265015AbSJPOmr>; Wed, 16 Oct 2002 10:42:47 -0400
Date: Wed, 16 Oct 2002 15:48:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
Message-ID: <20021016154842.A13211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DAC337D.7010804@snapgear.com> <20021015181609.A31647@infradead.org> <3DAD7AA9.1060207@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAD7AA9.1060207@snapgear.com>; from gerg@snapgear.com on Thu, Oct 17, 2002 at 12:41:45AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This isn't old. It is the primary format used on uClinux. ELF
> and a.out are not practical, since you would need to do the final
> link/locate on them at exec load time (you won't know what address
> in memory they will get loaded to until them). You don have the
> VM luxary of just locating it at a fixed address at compile time.
> 
> FLAT format is a light weight, mostly architecture independant
> way to carry around relocs, and to keep the program binaries
> small.

I don't meant binfmt_flat itself but the support for the old-style relocs
that is still in the code.

BTW, does binfmt_flat for for any non-uClinux port?

