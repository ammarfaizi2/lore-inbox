Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVFCVhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFCVhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVFCVhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:37:33 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:59012 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVFCVhT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:37:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bDaBwGZAdZDK2i2k72st+Z6ZonoC1I+ZsmM7uNRpKyS4UCEDd6w3cec7hkLa3RPL9XLt/1bnLuScUqT4ms8zu+KryF0gqPymUAr6+40YTUUuUVtLcbfRljTCNvJb7hHIreFR6jMunu2Sp7Y0j9x3YDQbu6DxFBvX31M9fHxXe20=
Message-ID: <d120d50005060314375ada10b8@mail.gmail.com>
Date: Fri, 3 Jun 2005 16:37:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
In-Reply-To: <20050603211625.GA17637@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4258F74D.2010905@keyaccess.nl>
	 <20050414100454.GC3958@nd47.coderock.org>
	 <20050526122315.GA3880@nd47.coderock.org>
	 <20050526122724.GA3396@ucw.cz> <20050603211625.GA17637@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/05, Wakko Warner <wakko@animx.eu.org> wrote:
> Vojtech Pavlik wrote:
> > On Thu, May 26, 2005 at 02:23:15PM +0200, Domen Puncer wrote:
> >
> > > Still true for 2.6.12-rc5. Should probably be fixed before final.
> >
> > Caused by a bug in the atkbd-scroll feature. The attached patch
> > fixes it.
> 
> Yes it does, thanks.  What's the "scroll" feature?
> 

Some keyboards have scroll-wheel, unfortunately there is no way to
detect whether is is present or not. Recently support for such wheels
was activated in atkbd by default.

-- 
Dmitry
