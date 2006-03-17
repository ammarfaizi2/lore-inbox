Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWCQTat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWCQTat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCQTat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:30:49 -0500
Received: from main.gmane.org ([80.91.229.2]:37508 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751004AbWCQTat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:30:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Fri, 17 Mar 2006 19:29:53 +0000
Message-ID: <yw1xmzfo98em.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:JEAv+UzqSx/VmWT5aIiX9K5LnIc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Jan-Benedict Glaw wrote:
>
>>>   Thank you for contacting ASUS Customer Service.
>>>   My name is ZYC, and I would be assisting you today.
>> 
>> Interesting name...
>
> Yeah, I have a link to the asus page where my case is handled, if you
> want. ;-)
>
>> Maybe the fix was running too late? There needs to be a PCI bus scan
>> afterwards...  Test with a newer kernel version, hopefully not patched
>> to death...
>
> I tested with 2.6.16-rc6. The only patch (aside of this one) I applied was
> the libata patch as I need support for the PATA port on a Promise
> controller. 
> It doesn't work and nothing appears in the log (not even the text that it is
> still "hiding"). I'm starting to think that I missed some step. Is there
> something else needed aside of applying the patch as it is, recompile the
> kernel and install it?

I didn't do anything else.  Check that your chipset has the same PCI
ID that the patch is for.

-- 
Måns Rullgård
mru@inprovide.com

