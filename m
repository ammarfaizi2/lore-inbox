Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWAXCCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWAXCCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWAXCCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:02:50 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:1729 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1030298AbWAXCCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:02:49 -0500
Message-ID: <43D58AA8.2090903@cfl.rr.com>
Date: Mon, 23 Jan 2006 21:02:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: vherva@vianova.fi
CC: Heinz Mauelshagen <mauelshagen@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Neil Brown <neilb@suse.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123125420.GE1686@vianova.fi>
In-Reply-To: <20060123125420.GE1686@vianova.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> PS: Speaking of debugging failing initrd init scripts; it would be nice if
> the kernel gave an error message on wrong initrd format rather than silently
> failing... Yes, I forgot to make the cpio with the "-H newc" option :-/.
>   

LOL, yea, that one got me too when I was first getting back into linux a 
few months ago and had to customize my initramfs to include dmraid to 
recognize my hardware fakeraid raid0.  Then I discovered the mkinitramfs 
utility which makes things much nicer ;)


