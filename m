Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267688AbUG3Oa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267688AbUG3Oa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUG3OaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:30:22 -0400
Received: from monster.roma2.infn.it ([141.108.255.100]:44702 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S267688AbUG3OaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:30:16 -0400
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: tty1 and italian charset ...
Date: Fri, 30 Jul 2004 16:30:09 +0200
User-Agent: KMail/1.6.2
References: <200407261647.40006.AlberT@SuperAlberT.it> <200407280934.00373.AlberT@SuperAlberT.it> <20040729163133.GC4008@pclin040.win.tue.nl>
In-Reply-To: <20040729163133.GC4008@pclin040.win.tue.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407301630.09754.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:31, giovedì 29 luglio 2004, you wrote:
> > > Sounds like you're trying to print Latin-1 on an UTF-8 console or vice
> > > versa.
> > >
> > >         echo -ne '\\033%G'      -- Enable UTF-8
> > >         echo -ne '\\033%@'      -- Disable UTF-8
> > >
> > >         -hpa
>
> (If it is not that, then investigate your font, etc.
> This is probably not a kernel matter.)

yep, I tried them ... without the double backslash :-)

they just turn UTF-8 on/off ... no change about my problem.
What problem in my font ??  why should my font works wrong _only_ on tty1 ???

is there a place in kernel where I could set a wrong font for console, and a 
reason explaining why this affects only tty1 ?



-- 
<?php echo '       Emiliano `AlberT` Gabrielli       ',"\n",
           '  E-Mail: AlberT_AT_SuperAlberT_it  ',"\n",
           '  Web:    http://SuperAlberT.it  ',"\n",
'  IRC:    #php,#AES azzurra.com ',"\n",'ICQ: 158591185'; ?>
