Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280037AbRKIT17>; Fri, 9 Nov 2001 14:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKIT1u>; Fri, 9 Nov 2001 14:27:50 -0500
Received: from barn.holstein.com ([198.134.143.193]:47367 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S280037AbRKIT1h>;
	Fri, 9 Nov 2001 14:27:37 -0500
Date: Fri, 9 Nov 2001 14:26:41 -0500
Message-Id: <200111091926.fA9JQfq11345@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: lkml-frank@unternet.org
Cc: VANDROVE@vc.cvut.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20011108233954.D11523@unternet.org> (message from Frank de Lange
	on Thu, 8 Nov 2001 23:39:54 +0100)
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
Reply-To: troy@holstein.com
In-Reply-To: <8A11A922758@vcnet.vc.cvut.cz> <20011108233954.D11523@unternet.org>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/09/2001 02:26:45 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/09/2001 02:26:46 PM,
	Serialize complete at 11/09/2001 02:26:46 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a matter of fact, yes.  In fact, I think this was actually to problem
I encountered a few days ago that I reported (I thought it was a loopback
problem).  I'm running on a DELL Optiplex GX1 though.

-- todd --

--text follows this line--
>  X-Apparently-To: todd_m_roy@yahoo.com via web13603.mail.yahoo.com; 08 Nov 2001 14:44:59 -0800 (PST)
>  X-RocketRCL: -1;0;0
>  X-Track: 1: 40
>  X-Authentication-Warning: www.unternet.org: frank set sender to lkml-frank@unternet.org using -f
>  Date:	Thu, 8 Nov 2001 23:39:54 +0100
>  From:	Frank de Lange <lkml-frank@unternet.org>
>  Cc:	linux-kernel@vger.kernel.org
>  Content-Disposition: inline
>  Sender:	linux-kernel-owner@vger.kernel.org
>  X-Mailing-List:	linux-kernel@vger.kernel.org
>  
>  On Thu, Nov 08, 2001 at 11:34:38PM +0000, Petr Vandrovec wrote:
>  > If you see something different from your box, or from your VMs, tell me. 
>  > But adding some SCSI adapter is beyond PCI slots of my box. I also
>  > assume that you are using released VMware version, build 1455.
>  
>  Yeah, using VMware build 1455 on ABit BP-6 with 2 * Celeron 466@466, 768 MB RAM
>  (dirt cheap nowadays so why not...), 2 * Maxtor 40GB IDE on BX controller, HPT
>  controller not in use, Matrox G400. I've seen the rtc: blah errors, stressed
>  the box to its limits with VM's with Linux/WinXP, and every now and then...
>  
>  it just freezes... (only when using a Linus kernel, and only when using VMware)
>  
>  I'll try 2.4.15pre, maybe it helps...
>  
>  Cheers//Frank
>  -- 
>    WWWWW      _______________________
>   ## o o\    /     Frank de Lange     \
>   }#   \|   /                          \
>    ##---# _/     <Hacker for Hire>      \
>     ####   \      +31-320-252965        /
>             \    frank@unternet.org    /
>              -------------------------
>   [ "Omnis enim res, quae dando non deficit, dum habetur
>      et non datur, nondum habetur, quomodo habenda est."  ]
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  
