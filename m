Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSEBVmH>; Thu, 2 May 2002 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEBVmH>; Thu, 2 May 2002 17:42:07 -0400
Received: from ns.suse.de ([213.95.15.193]:42256 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315442AbSEBVmG>;
	Thu, 2 May 2002 17:42:06 -0400
Date: Thu, 2 May 2002 23:42:02 +0200
From: Dave Jones <davej@suse.de>
To: tomas szepe <kala@pinerecords.com>
Cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502234202.X16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	tomas szepe <kala@pinerecords.com>, Keith Owens <kaos@ocs.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020502103810.GA7937@louise.pinerecords.com> <28926.1020342106@ocs3.intra.ocs.com.au> <20020502213443.GA10617@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 11:34:44PM +0200, tomas szepe wrote:
 > '/usr/include/asm' points to '/usr/src/linux/include/asm'

Therein lies your problem.
/usr/include/asm should NOT be a symlink.  At least, not in this century.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
