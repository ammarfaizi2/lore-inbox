Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVLOVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVLOVpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVLOVpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:45:11 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:44130 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751129AbVLOVpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:45:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b2cUDCeNBvDrvnkk1bSkQp2xlw/zue+Es8XAjKntnWnsImx+HUtVGQsAj72kDmMHxBCS/9U9U55WKpgJEUN+DpAfzcHHkCw9/d5hXrGzlrVPb6guC7H5gPt1SSozkaw5QbQRF1e5q0XYESBJH4H+vCWIiN+DsIfIHDmKIBeWyIE=
Message-ID: <d120d5000512151338p7ec77170i555358b9624c1649@mail.gmail.com>
Date: Thu, 15 Dec 2005 16:38:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Cc: Olof Johansson <olof@lixom.net>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20051215212635.GA6195@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213223659.GB20017@hansmi.ch>
	 <1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch>
	 <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
	 <20051214233108.GA20127@hansmi.ch>
	 <20051215195017.GA7195@pb15.lixom.net>
	 <20051215212635.GA6195@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> On Thu, Dec 15, 2005 at 11:50:17AM -0800, Olof Johansson wrote:
> > I think I agree with previous comments regarding debug code in the driver:
> > It's unlikely to ever be used by more than a couple of people at very
> > rare occasions (new hardware releases), and the barrier to using it is
> > still high; new users need to learn how to parse the data anyway. I don't
> > see a reason to include this in mainline.
>
> Okay, based on your comments, please drop that patch. How about the one
> to support the Geyser 2 device? Should I do a rediff without relayfs
> support?
>

If you could rediff it without relayfs I would add it to the input
tree. Altough I am not sure if manually unrolling that loop is such a
good idea. Maybe we should leave it to the compiler?

--
Dmitry
