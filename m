Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUIZN2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUIZN2j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 09:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUIZN2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 09:28:39 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:54802 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269523AbUIZN2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 09:28:37 -0400
Message-ID: <33070.192.168.1.5.1096204190.squirrel@192.168.1.5>
In-Reply-To: <200409251637.29401.david-b@pacbell.net>
References: <414F8CFB.3030901@cybsft.com>
    <25766.195.245.190.94.1096034422.squirrel@195.245.190.94>
    <200409241016.46201.bjorn.helgaas@hp.com>
    <200409251637.29401.david-b@pacbell.net>
Date: Sun, 26 Sep 2004 14:09:50 +0100 (WEST)
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "David Brownell" <david-b@pacbell.net>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 26 Sep 2004 13:28:33.0295 (UTC) FILETIME=[B83E19F0:01C4A3CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Bjorn Helgaas wrote:
>>
>> The attached patch (which applies on top of Rui's patch for
>> ALI M5237) fixes the problem for my DL360.
>
> Hmm, I'd rather avoid needing a quirk table ... especially
> when I've always suspected this is some subtle bug in the
> way Linux initializes!  Does this patch behave too?
>

The patch works on my ALI M5237, having ohci_hcd (re)starting properly. No
need for my previous specific patch.

Thanks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

