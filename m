Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272691AbTHKPDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHKPDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:03:08 -0400
Received: from www.13thfloor.at ([212.16.59.250]:49851 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272691AbTHKO74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:59:56 -0400
Date: Mon, 11 Aug 2003 16:59:40 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, gaxt@rogers.com, henrik@fangorn.dk,
       romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, babydr@baby-dragons.com,
       len.brown@intel.com
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030811145940.GF4562@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	Andrew Morton <akpm@osdl.org>, gaxt@rogers.com, henrik@fangorn.dk,
	romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
	felipe_alfaro@linuxmail.org, babydr@baby-dragons.com,
	len.brown@intel.com
References: <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030811053437.GA19040@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 07:34:37AM +0200, Norbert Preining wrote:
> On Son, 10 Aug 2003, Andrew Morton wrote:
> > > I tried as boot cmd line:
> > >  	s root=03:41 acpi=off
> > >  and still it didn't work. Same problem.
> > 
> > It is decimal.  You want 03:65.
> 
> Still no success. With acpi=off and without.
> 
> 
> > Could you test this patch?  It should put things back to the way
> > they were before this mini-fisaco. root=0341 should work as well.
> 
> Also no success.
> 
> Maybe I am stupid, but 
> 	make mrproper
> 	make distclean
> 	make config deb bzImage modules modules_install
> should be enough to make a clean kernel? And, AFAIK, I compiled in ext3
> and all other necessary stuff. Soon I give up.

make config
make

should be sufficient (dep, bzImage, modules is not required)

maybe you could provide your .config?

best,
Herbert

> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> BEAULIEU HILL
> The optimum vantage point from which one to view people undressing in
> the bedroom across the street.
> 			--- Douglas Adams, The Meaning of Liff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
