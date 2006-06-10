Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWFJSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWFJSOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbWFJSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:14:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:22160 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030487AbWFJSOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:14:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lC0eMEKuYK/hvzF/+VETIH8CHgRFVAx+v9LuqD0Ghkp5ClvfbEvWqprI76P2rmcBpxmeSZ6/lBSejpQ/wzH7tCMz5Q4HYBYCBOudE1r4lumhxaSXCHEKTD4JJWbFBn7fBSqpi4Lg7ud6PFDhBQhU9GEX/JZ3iriSCoNwczQY2dc=
Message-ID: <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
Date: Sat, 10 Jun 2006 20:14:18 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
	 <20060610092412.66dd109f.akpm@osdl.org>
	 <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
	 <20060610100318.8900f849.akpm@osdl.org>
	 <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On 10/06/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Sat, 10 Jun 2006, Andrew Morton wrote:
>
> > I've placed a rollup of 2.6.17-rc6-mm2 minus the zoned-vm and eventcounter
> > patches at
>
> Oh. So 2.6.17-rc6-mm2 is out with that counter patchset.
>
> If someone needs a fix then please try this patch that was posted last
> night. Seems that was too late for 2.6.17-rc6-mm2.
>
>

[michal@ltg01-fedora linux-mm]$ cat ~/page_alloc.patch | patch -p1 --dry-run
patching file mm/page_alloc.c
Hunk #1 FAILED at 1583.
Hunk #2 succeeded at 1604 (offset 1 line).
1 out of 3 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
patching file include/linux/page-flags.h

PITA for people that aren't kernel hackers.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
