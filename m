Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751066AbWFEMnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWFEMnv (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWFEMnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:43:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:2382 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751065AbWFEMns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:43:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kT1ynY+sWemsZ4fH2DPcDxfh9g78AUIFvEHMPlSDJ4FiZXyBsXebCUdgL4RhvSAOm54HpHngAm3kc+RatKoGrFmzL8xLVRShEOlcRFjJagYcsEl/g2Uge7vbkeIPgg8x/2wOWaPaERSbLUvy8vDVWs2JC/0IXgfz9JsjkZrlYhM=
Message-ID: <448426FE.8090801@gmail.com>
Date: Mon, 05 Jun 2006 21:43:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume
 and actual wakeup
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com>
In-Reply-To: <44841AA0.4060404@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Pavel Machek wrote:
>> If you want to know if you RESUME was after normal FREEZE or if it is
>> after reboot, there's better patch floating around to do that.
> 
> Yeap, this is what I'm interested in.  Care to give me a pointer?

And, one more things.  As written in the first mail, for libata, it 
would be nice to know if a device suspend is due to runtime PM event 
(per-device) or system wide suspend.  What do you think about this?  If 
you agree, what method do you recommend to determine that?

Thanks a lot.

-- 
tejun
