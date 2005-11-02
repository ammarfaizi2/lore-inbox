Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbVKBFim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbVKBFim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVKBFim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:38:42 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:15223 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751513AbVKBFil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:38:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pA7huA0k1dHbkvg5NsZds1B3FTUZwKr7DC5jKXFjOMbdT61hDNga+UaLPwSxngXAZXm7CoF3h1EEW8VPB7CYH/KN+Mkmx88LHFNfdPHtiuMiycZoZVX8qI8LPbdMAvRjNlah5xLJX2i2DxgqQj4A1H0mswyW8Y2b2NTlIDkZ6hQ=
Message-ID: <436850BA.5010808@gmail.com>
Date: Wed, 02 Nov 2005 16:38:02 +1100
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <greg@kroah.com>, Grant Coady <lkml@dodo.com.au>,
       "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com> <20050911031150.GA20536@kroah.com> <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com> <4323EFFE.2040102@pobox.com>
In-Reply-To: <4323EFFE.2040102@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> pci_ids.h should be the place where PCI IDs (class, vendor, device) are 
> collected.
> 
> Long term, we should be able to trim a lot of device ids, since they are 
> usually only used in one place.
> 
These two sentences seem mutually exclusive to me, you want pci_ids collected
in the header file, _and_ then trim single use IDs from which: the header,
or the source.c file defining them?  Present usage is ~50/50, which way to
go?

Grant.
