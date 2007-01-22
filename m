Return-Path: <linux-kernel-owner+w=401wt.eu-S1751880AbXAVCjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXAVCjp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 21:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXAVCjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 21:39:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28530 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbXAVCjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 21:39:44 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Hul8oqDSj2Xs2ZjP85Sg92gV8lblAaXEilsfXkdT5MisRM8C9uPJeWBEk4LbYs3FgF0YM0LYeZo43KFBXErkVtuNNj+mpVgCBGJZxe06WwjSuDMMvwrJehf3GowndKPESXsv9juINMGIs7mkXR8QczOB5xQbj6gprpP2+lJqW20=
Message-ID: <45B423CB.9020106@gmail.com>
Date: Mon, 22 Jan 2007 11:39:07 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Chr <chunkeey@web.de>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, jens.axboe@oracle.com, lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701211834.41306.chunkeey@web.de> <20070121180113.GC2441@atjola.homenet> <200701212113.22965.chunkeey@web.de>
In-Reply-To: <200701212113.22965.chunkeey@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chr wrote:
> Ok, you won't believe this... I opened my case and rewired my drives... 
> And guess what, my second (aka the "good") HDD is now failing! 
> I guess, my mainboard has a (but maybe two, or three :( ) "bad" sata-port(s)!  

Or, you have power related problem.  Try to rewire the power lines or 
connect harddrives to a separate powersupply.  It's often useful to 
change one component at a time and watch which change the problem 
follows.  Anyways, you seem to be suffering transmission failures, not a 
driver problem.

Thanks.

-- 
tejun
