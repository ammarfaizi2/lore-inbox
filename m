Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUG1HyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUG1HyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUG1HxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:53:05 -0400
Received: from monster.roma2.infn.it ([141.108.255.100]:39655 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S266817AbUG1HeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:34:10 -0400
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: Re: tty1 and italian charset ...
Date: Wed, 28 Jul 2004 09:34:00 +0200
User-Agent: KMail/1.6.2
References: <200407261647.40006.AlberT@SuperAlberT.it> <ce6u0e$c3t$1@terminus.zytor.com>
In-Reply-To: <ce6u0e$c3t$1@terminus.zytor.com>
Cc: hpa@zytor.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Message-Id: <200407280934.00373.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03:03, mercoledì 28 luglio 2004, you wrote:
> > I already used "loadkeys it" and it seems to success, but tty1 still
> > doesn't prints "Ã²Ã Ã¨Ã¬Ã¹" characters.

uh ??

no sorry, you are not seeing the characters I'm trying to type...
my charset is setted (on system-wide basis) to it_IT@EURO, no UTF-8 ... btw, 
tryng to use UTF-8, iso-15, iso-1 and so on does not affect the problem.

The characters I'm tring to print are the "italian single letter" that on a us 
keyboard I would type as " a` ", " e` ", " e' ", " i` ", "o` ", " u` " ...

I repeat that the strange thing is that _only_ tty1 as this strange 
beahviour .. not dipending on the user logged in (infact I have this problem 
already at login time, when I have to type the login name... If I'd have a 
login name containing one of this characters I could not login from tty1)...

Is tty1 somehow special in respect to other ttys ???


>
> Sounds like you're trying to print Latin-1 on an UTF-8 console or vice
> versa.
>
>         echo -ne '\\033%G'      -- Enable UTF-8
>         echo -ne '\\033%@'      -- Disable UTF-8
>
>         -hpa

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       ',"\n",
           '  E-Mail: AlberT_AT_SuperAlberT_it  ',"\n",
           '  Web:    http://SuperAlberT.it  ',"\n",
'  IRC:    #php,#AES azzurra.com ',"\n",'ICQ: 158591185'; ?>
