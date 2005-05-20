Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVETULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVETULL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVETULL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:11:11 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:25575 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261567AbVETULD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:11:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYB9QrguDvjkquA4QR34n0hNQr1t1Um76r8tS0CvQlBA+RJ3Sl3Qkj7J1lojB3sWxtt+xcVe8JcdWecVhNlQm3HWBr1o4afz6vmv7CoVhwBvH4+oXJ/TvVHOhZTK8pXrmOSm0gPad2z/7BLS6HNpCpCCq+8YMB8XtKY9K53oi40=
Message-ID: <d120d500050520131118e42cc5@mail.gmail.com>
Date: Fri, 20 May 2005 15:11:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Cc: Tom Rini <trini@kernel.crashing.org>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1116618493.12975.48.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050519164323.GK3771@smtp.west.cox.net>
	 <1116573175.7647.4.camel@dhcp-188.off.vrfy.org>
	 <20050520171808.GM3771@smtp.west.cox.net>
	 <1116611802.12975.19.camel@dhcp-188>
	 <d120d5000505201207227edf4a@mail.gmail.com>
	 <1116618493.12975.48.camel@dhcp-188>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> On Fri, 2005-05-20 at 14:07 -0500, Dmitry Torokhov wrote:
> > On 5/20/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > >
> > > Well, it doesn't depend on "make it private" it depends on Dimitry, who
> > > wanted to tweak our patch for the input layer. But we wait for weeeks
> > > for that. The SUSE kernel already ships a driver-core input layer
> > > without the /sbin/hotplug stuff.
> > >
> >
> > Kay,
> >
> > I am sorry for being slow with these patches but I really do spend all
> > time that I can on kernel.
> 
> Oh well, I know that problem. :) We need to move completely away from
> unmanaged kernel-forked processes in the hotplug area. SUSE 9.3 already
> ships a udevd that listens only on netlink for hotplug messages
> and /proc/sys/kernel/hotplug is set to "".
> Hannes converted the input layer to a input_device class to get the
> event through netlink. Maybe you can have a second look at it, so that
> we can get that thing upstream soon to fix the last broken hotplug-user
> and make hotplug_path finally private.
> 

Could you send me the tlatest version, please? Lats time I think there
were some concerns about lifetime rules...

-- 
Dmitry
