Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWAEQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWAEQBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWAEQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:01:14 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:17157 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751463AbWAEQBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:01:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SHY3tnNLSaZRg4b0kLoKA1piWX4Rx/n4Pwy9OONYyQro2O9r52pWpMxkjFKIET93O2dHdvMN6rmUjvw2uubvmonnQgo4UhhjGacxAg2nGaYJD6i0HFVCd6LgQx+sLIlzb7brBnpbfx6qcQjrwxMJ6lSV8Yk+7HdtyQo0VNFd2nA=
Message-ID: <43BD42E5.5040704@gmail.com>
Date: Thu, 05 Jan 2006 21:01:41 +0500
From: "Alexander E. Patrakov" <patrakov@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Galibert <galibert@pobox.com>,
       Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz> <20060105145101.GB28611@dspnet.fr.eu.org> <43BD3AAC.9000104@gmail.com> <Pine.LNX.4.61.0601051627590.10350@tm8103.perex-int.cz>
In-Reply-To: <Pine.LNX.4.61.0601051627590.10350@tm8103.perex-int.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:

>You can also use plughw:CARDID,0 or so notation. 
>  
>
Thanks, it works here indeed.

>Identification of cards are available via control interface or look 
>to /proc/asound/cards file. The card ID string can be set via
>a module option. Also you can fix the card index numbers with
>a module option.
>  
>
The point here is that virtually every other subsystem can use udev to 
rename devices and/or create symlinks. For ALSA, an ALSA-specific 
solution has to be used. Although, I admit that udev offers nothing over 
this solution for my sound card.

-- 
Alexander E. Patrakov
