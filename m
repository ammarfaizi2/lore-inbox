Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCRRi2>; Mon, 18 Mar 2002 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCRRiS>; Mon, 18 Mar 2002 12:38:18 -0500
Received: from ns.suse.de ([213.95.15.193]:60167 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290593AbSCRRiB>;
	Mon, 18 Mar 2002 12:38:01 -0500
Date: Mon, 18 Mar 2002 18:37:59 +0100
From: Dave Jones <davej@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: [-ENOCOMPILE] ataraid as module in linux-2.5.7-pre2
Message-ID: <20020318183759.E17410@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203180938.g2I9c1q27846@Port.imtp.ilyichevsk.odessa.ua> <20020318142240.D3025@suse.de> <200203181341.g2IDfbq28679@Port.imtp.ilyichevsk.odessa.ua> <20020318145313.E3025@suse.de> <20020318164215.GI2254@matchmail.com> <20020318174527.C17410@suse.de> <20020318172304.GJ2254@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >     * Some reports of unknown cause of ext2 corruption since 2.5.3 (not
 > related to the missing i_fsize clearing from .3pre3-5)
 > 
 > It would be good to report the last version that this problem was reported
 > against, and this type of problem can't really be tested on each pre patch.
 > That's basically what I was asking for before...

Gotcha. Point taken.

 > # IDE floppy oops on some (zip100) setups. (Triggers BUG_ON() in
 > elevator.c:237)
 > 
 > If the version is reported for this then you can see what function was being
 > reported at the time.  Otherwise some other patch could shift the contents
 > to make line 237 point to another function (rewrites and such...)

 I'll make those BUG() descriptions include the function name & BUG condition
 in future descriptions.

 Thanks for the feedback
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
