Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276958AbRJCTfR>; Wed, 3 Oct 2001 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276959AbRJCTe5>; Wed, 3 Oct 2001 15:34:57 -0400
Received: from ppp36.ts2.Gloucester.visi.net ([209.96.247.100]:1528 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S276958AbRJCTeu>; Wed, 3 Oct 2001 15:34:50 -0400
Date: Wed, 3 Oct 2001 15:32:51 -0400
From: Ben Collins <bcollins@debian.org>
To: Linux Bigot <linuxopinion@yahoo.com>
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
Message-ID: <20011003153251.F319@visi.net>
In-Reply-To: <20011003163700.66539.qmail@web14803.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011003163700.66539.qmail@web14803.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 09:37:00AM -0700, Linux Bigot wrote:
> Please tell me why can't I use bus_to_virt().

Because bus_to_virt/virt_to_bus is obsolete, and using it will make your
driver non-portable to some architectures.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
