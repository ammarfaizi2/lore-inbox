Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKBMaH>; Fri, 2 Nov 2001 07:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280671AbRKBM36>; Fri, 2 Nov 2001 07:29:58 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:13220 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S280666AbRKBM3k>; Fri, 2 Nov 2001 07:29:40 -0500
Date: Fri, 2 Nov 2001 07:29:39 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 3.0.2 fails to build linux-2.4.13-ac5, 8139.c
Message-ID: <20011102072939.A1119@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200111020921.fA29LP718803@vegae.deep.net> <E15zd1M-00024u-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15zd1M-00024u-00@the-village.bc.nu>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20011102 (Fri) at 1202:00 +0000, Alan Cox wrote:
> > 8139too.c:2432: Internal compiler error in reload_cse_simplify_operands, at reload1.c:8364
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
> 
> You reported the bug to the wrong place. Its a compiler bug not a kernel
> bug.

Interesting though: I had exactly the same error with gcc 3.0.1, but
for me 3.0.2 has compiled that file correctly in a couple of
13-ac releases, including -ac5.  The resulting kernels are about 8%
bigger, and seem a trifle slower, than the same ones compiled with
2.95.3 -- IIRC other people have found the same, so maybe the easy
fix is to wait a few versions before using gcc 3 for kernel
compilation.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
