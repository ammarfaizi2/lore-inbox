Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbQLNVDg>; Thu, 14 Dec 2000 16:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbQLNVD1>; Thu, 14 Dec 2000 16:03:27 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:22727 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132762AbQLNVDQ>;
	Thu, 14 Dec 2000 16:03:16 -0500
From: thunder7@xs4all.nl
Date: Thu, 14 Dec 2000 21:09:41 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001214210941.A707@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <079301c06576$b303f060$0301a8c0@symonds.net> <E146V8k-00043W-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <E146V8k-00043W-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 09:57:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 09:57:28AM +0000, Alan Cox wrote:
> > bug was discovered.  Ever since, I have two boxes here
> > that keep falling over.  Box A will randomly lock without 
> > warning and box B will die and start printing this message 
> > repeatedly on the screen until I physically hit reset:
> 
> What are these two boxes doing ?
> 
> > Is there a patch out there that I can apply to 2.2.14
> > against the security bug?  The machines were very stable
> > on that kernel.
> 
> Andrea's VM-global patch seems to be a wonder cure for those who have tried
> it. Give it a shot and let folks know.
My experience:

2.2.18pre25 erroneously booted with mem=64M:

slrnpull --expire on a news-spool of about 600 Mb in 200,000 files gave
a lot of 'trying_to_free..' errors.

2.2.18 + VM-global, booted with mem=32M:

slrnpull --expire on the same spool worked fine.

Good luck,
Jurriaan
-- 
proof by reference to inaccessible literature:
	The author cites a simple corollary of a theorem to be found 
	in a privately circulated memoir of the Slovenian 
	Philological Society, 1883 (second edition).
GNU/Linux 2.2.18 SMP 2x1117 bogomips load av: 0.56 0.15 0.05
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
