Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWEIPpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWEIPpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWEIPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:45:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:7954 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750837AbWEIPpq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:45:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ies4Rv1ibdYsAtB2N18JsPChoFLKYXFogfVCUtzK0uOrl8nNcTT14RaZVo24tr+gI0HHgH+o+Kwrp6lg+45TIbkgUJmFAKeqXfFqJgXWRkC4xVr2MV09o5O6h9NwfSGMYAgW3CMEdtJxB/1ON8Isgt+GlliiUHWPrCiXSdKRepg=
Message-ID: <84144f020605090845m722d68c1l375e54fc6aa1f297@mail.gmail.com>
Date: Tue, 9 May 2006 18:45:45 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Hellwig" <hch@infradead.org>, "Andi Kleen" <ak@suse.de>,
       "Chris Wright" <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
In-Reply-To: <20060509152240.GA17837@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060509084945.373541000@sous-sol.org>
	 <4460AC01.5020503@mbligh.org> <20060509150701.GA14050@infradead.org>
	 <p73k68v4444.fsf@bragg.suse.de> <20060509152240.GA17837@infradead.org>
X-Google-Sender-Auth: dc5c28fb7588fdb1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 05:20:11PM +0200, Andi Kleen wrote:
> > > It's also wrong.  There's more than one hypervisor and Xen shouldn't just
> > > grab this namespace.  make it xen_ or xenhv_.
> >
> > You should reject the recent "hypervisor file system" with the same
> > argument then.

On 5/9/06, Christoph Hellwig <hch@infradead.org> wrote:
> I prefer it would become lparfs or something like that indeed.

AFAIK it's called s390-hypfs now.

                                      Pekka
