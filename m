Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135226AbRD3Nlz>; Mon, 30 Apr 2001 09:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbRD3Nlp>; Mon, 30 Apr 2001 09:41:45 -0400
Received: from barn.holstein.com ([198.134.143.193]:29198 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S133019AbRD3Nld>;
	Mon, 30 Apr 2001 09:41:33 -0400
Date: Mon, 30 Apr 2001 13:40:23 GMT
Message-Id: <200104301340.f3UDeN115068@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010430013956.A1578@emma1.emma.line.org> (message from Matthias
	Andree on Mon, 30 Apr 2001 01:39:56 +0200)
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Reply-To: troy@holstein.com
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org> <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com> <20010429122546.A1419@werewolf.able.es> <20010430013956.A1578@emma1.emma.line.org>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/30/2001 09:40:26 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/30/2001 09:40:27 AM,
	Serialize complete at 04/30/2001 09:40:27 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias,
  I tried pretty much the same thing, and I also tried your patch.
Unhappily when I access my zip drive using the aic7xxx driver my system
becomes pretty much unresposive, just short of locking up completely.
ie at least the emergency alt-sysrq keys still work.

I guess we'll just have to wait for Justin to come out with the real patch...

-- todd -- 



>  X-Apparently-To: todd_m_roy@yahoo.com via web13607.mail.yahoo.com
>  X-Track: 1: 40
>  Date:	Mon, 30 Apr 2001 01:39:56 +0200
>  From:	Matthias Andree <matthias.andree@stud.uni-dortmund.de>
>  Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
>  Content-Type: text/plain; charset=us-ascii
>  Content-Disposition: inline
>  User-Agent: Mutt/1.2.5i
>  Sender:	linux-kernel-owner@vger.kernel.org
>  Precedence: bulk
>  X-Mailing-List:	linux-kernel@vger.kernel.org
>  
>  On Sun, 29 Apr 2001, J . A . Magallon wrote:
>  
>  > >              Command found on device queue
>  > > aic7xxx_abort returns 8194
>  > 
>  > I have seen blaming for this error to aic7xxx new driver prior to version
>  > 6.1.11. It was included in the 2.4.3-ac series, but its has not got into
>  > main 2.4.4 (there is still 6.1.5). Everything needs its time.
>  
>  Since the official aic7xxx site doesn't carry a patch against 2.4.4 yet
>  (just 2.4.3) which has cosmetic issues when being patched, I made a
>  patch against 2.4.4: I took the 2.4.3-aic7xxx-6.1.12 patch, applied to
>  2.4.4, bumped the version to read -ma1 in EXTRAVERSION, and made a new
>  patch against vanilla 2.4.4, to be found at:
>  
>  *** WARNING BELOW ***
>  
>  http://mandree.home.pages.de/kernelpatches/v2.4/v2.4.4/
>   72k linux-2.4.4-aic7xxx-to-6.1.12.patch.gz
>  
>  Apply with patch -p1.
>  
>  NOTE: Do not expect this patch to last until after either Justin has a
>  patch against 2.4.4 available or 2.4.5 has been released.
>  
>  *** WARNING *** I did not yet try to boot it, that will have to wait
>  until later.
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  

**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
