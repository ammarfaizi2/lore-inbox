Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbQLOSTS>; Fri, 15 Dec 2000 13:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQLOSTI>; Fri, 15 Dec 2000 13:19:08 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:18647 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129370AbQLOSS4>; Fri, 15 Dec 2000 13:18:56 -0500
Date: Fri, 15 Dec 2000 19:47:35 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Eckhard Jokisch <e.jokisch@u-code.de>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: test12 lockups -- need feedback
Message-ID: <20001215194735.K829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <00121418523403.16098@eckhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <00121418523403.16098@eckhard>; from e.jokisch@u-code.de on Thu, Dec 14, 2000 at 06:52:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 06:52:34PM +0000, Eckhard Jokisch wrote:
> Is it possible that there is something wrong with the 8139too driver? 
> ( I also use a card with 8139 chip )
> Or do you use the "old" rtl8139 ? With that I don't have any problems.
> I have an extra machine here where I can do all testing - how can I help?

I have no Realtek-Card and have the same lockup.

I also got a hard lockup (but with Oops) while calling the
"vendor CPU init" function during system boot.

This was on Cyrix III.

PS: CC'ed hpa, because he is cpu-detection maintainer and davej,
   because he added Cyrix III support and might know details ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
