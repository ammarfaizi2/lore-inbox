Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314672AbSEFTB3>; Mon, 6 May 2002 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEFTB2>; Mon, 6 May 2002 15:01:28 -0400
Received: from ns.suse.de ([213.95.15.193]:15378 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314672AbSEFTB0>;
	Mon, 6 May 2002 15:01:26 -0400
Date: Mon, 6 May 2002 21:01:25 +0200
From: Dave Jones <davej@suse.de>
To: "Scott A. Sibert" <kernel@hollins.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14 ntfs.o module unresolved symbols
Message-ID: <20020506210125.E22215@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Scott A. Sibert" <kernel@hollins.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3CD6CCF5.8090903@hollins.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 02:35:33PM -0400, Scott A. Sibert wrote:
 > At make modules_install:
 > 
 > depmod: *** Unresolved symbols in 
 > /lib/modules/2.5.14-01/kernel/fs/ntfs/ntfs.o
 > depmod:     buffer_async
 > depmod:     set_buffer_async
 > depmod:     clear_buffer_async

http://www.codemonkey.org.uk/patches/merged/2.5.14/dj1/ntfs-compilefix.diff

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
