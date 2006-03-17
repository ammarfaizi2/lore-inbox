Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWCQSSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWCQSSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWCQSSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:18:33 -0500
Received: from main.gmane.org ([80.91.229.2]:2974 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030250AbWCQSSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:18:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Fri, 17 Mar 2006 20:18:02 +0200
Message-ID: <dveugj$aob$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.51.215
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

>>   Thank you for contacting ASUS Customer Service.
>>   My name is ZYC, and I would be assisting you today.
> 
> Interesting name...

Yeah, I have a link to the asus page where my case is handled, if you
want. ;-)

> Maybe the fix was running too late? There needs to be a PCI bus scan
> afterwards...  Test with a newer kernel version, hopefully not patched
> to death...

I tested with 2.6.16-rc6. The only patch (aside of this one) I applied was
the libata patch as I need support for the PATA port on a Promise
controller. 
It doesn't work and nothing appears in the log (not even the text that it is
still "hiding"). I'm starting to think that I missed some step. Is there
something else needed aside of applying the patch as it is, recompile the
kernel and install it?

I touch the kernel code only seldom, usually I port a patch from one version
to another, like the promise PATA patch to the SuSE kernel, but I don't
really know the kernel internals.

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


