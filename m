Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268773AbRG0EzH>; Fri, 27 Jul 2001 00:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268774AbRG0Ey5>; Fri, 27 Jul 2001 00:54:57 -0400
Received: from ppp01.ts3.Gloucester.visi.net ([206.246.230.129]:2295 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S268773AbRG0Eyu>; Fri, 27 Jul 2001 00:54:50 -0400
Date: Fri, 27 Jul 2001 00:54:51 -0400
From: Ben Collins <bcollins@debian.org>
To: Frank Davis <fdavis@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, fdavis112@juno.com
Subject: Re: 2.4.7-ac1: ohci1394.c parse error
Message-ID: <20010727005451.U5264@visi.net>
In-Reply-To: <Pine.GSO.4.21L-021.0107270015580.28563-100000@unix3.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21L-021.0107270015580.28563-100000@unix3.andrew.cmu.edu>; from fdavis@andrew.cmu.edu on Fri, Jul 27, 2001 at 12:18:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 12:18:04AM -0400, Frank Davis wrote:
> Hello all,
>  I haven't seen this posted. While 'make modules' on 2.4.7-ac1 , I
> received the following error:
> ohci1394.c:1451: parse error
> make[2]: *** [ohci1394.o] Error 1
> make[2]: Leaving directory '/usr/src/linux/drivers/ieee1394'
> make[1]: *** [modsubdir_ieee1394] Error 2

Change if "#if" on that line to "#ifdef". Fix has been sent to Linus.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
