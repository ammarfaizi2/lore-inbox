Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDUQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDUQJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVDUQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:09:39 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:40811 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVDUQJc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:09:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KN3IhkvGXjeqL/kKpP0IBYKgjSlMOqxwLwQpVcaUfUjNd5pewuLXfn9SpEk+QnCADTNWkudmwQd3zDwkHBQuKsStZ/bGnoQGys9QAKh/tsWkq14L5P05sST7BTeYt+LHJdVg1BvI4k+xnndl/vnW29vLJsBGSrOU68q/HtxokNA=
Message-ID: <d120d5000504210909f0e0713@mail.gmail.com>
Date: Thu, 21 Apr 2005 11:09:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <1114089504.29655.93.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing...

On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> 
> > w1-master-drop-attrs.patch
> >    Get rid of unneeded master device attributes:
> >    - 'pointer' and 'attempts' are meaningless for userspace;
> >    - information provided by 'slaves' and 'slave_count' can be gathered
> >      from other sysfs bits;
> >    - w1_slave_found has to be rearranged now that slave_count field is gone.
> 
> attempts is usefull for broken lines.

It simply increments with every search i.e. every 10 secondsby default
and does not provide indication of the quality of the wire.

-- 
Dmitry
