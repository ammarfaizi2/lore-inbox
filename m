Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRKNBsf>; Tue, 13 Nov 2001 20:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279986AbRKNBsZ>; Tue, 13 Nov 2001 20:48:25 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:50162 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S279981AbRKNBsL>; Tue, 13 Nov 2001 20:48:11 -0500
Date: Tue, 13 Nov 2001 20:48:09 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
Message-ID: <20011113204809.Q329@visi.net>
In-Reply-To: <20011113143947.F329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011113143947.F329@visi.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silly TILO. Seems 2.4.x is correctly doing things. TILO was setting HdrS
in the kernel to 0x0200 (floppy of course). So, 2.2.x was ignoring it
(the wrong behavior), and 2.4.x respects it. I changed TILO to use
0x0100, and now it boots just fine.

Sorry for the hubub.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
