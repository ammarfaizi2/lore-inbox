Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWFJTIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWFJTIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWFJTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:08:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:2486 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751671AbWFJTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:08:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mR4baT8TP13qpXSJLEh1apt20aP4m+N/hYhybdNZ7zRsAVoRY5p5NI9In3GlZ57aBrtsyUnF/FcxUlc5p7nVHv0H9FC2abH0tKYyw7Dt3+0sx+m29OoAEQGpMcrkqU1lKhOKd181rTB6BLUw1U1fgvA67iVTKb5LrCj049lrcvg=
Message-ID: <6bffcb0e0606101208y4e155371g78b9aea781f39fd4@mail.gmail.com>
Date: Sat, 10 Jun 2006 21:08:24 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606101131430.7535@schroedinger.engr.sgi.com>
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
	 <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
	 <6bffcb0e0606101126v55cc20dbk275d8aa7fdcb0f1a@mail.gmail.com>
	 <Pine.LNX.4.64.0606101131430.7535@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Sat, 10 Jun 2006, Michal Piotrowski wrote:
>
> > And I get this error
> > /usr/src/linux-mm/mm/page_alloc.c: In function 'vm_events_fold_cpu':
> > /usr/src/linux-mm/mm/page_alloc.c:2885: error: incompatible type for
> > argument 2 of 'count_vm_events'
> > /usr/src/linux-mm/mm/page_alloc.c:2886: error: invalid type argument of '->'
> > make[2]: *** [mm/page_alloc.o] B??d 1
> > make[1]: *** [mm] B??d 2
> > make: *** [_all] B??d 2
> >
> > As I said - pain in the ass for people that aren't kernel hackers.
>
> Hmmm. That is hotplug which I cannot enable on ia64. I checked this by
> moving the #ifdef CONFIG_HOTPLUG
>

Thanks! Now everything builds, works fine.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
