Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVETTH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVETTH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETTH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:07:58 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:48613 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261553AbVETTHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q8Qs+qa3Z5LUZOu38al5OdHcUz2cjEybOeO9vS/dVoHrcxydvgbejtyo7rcHxbpydgLy7ia8A1aixipl+n1hVIcU0hpbfFixMxx3JTjv7R0vjSxi6P/U2PbPNPfC3NdM5iJrScCD8jzp3sLksdRJzVyLx2nxtt1lNPQiKw4eGCM=
Message-ID: <d120d5000505201207227edf4a@mail.gmail.com>
Date: Fri, 20 May 2005 14:07:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Cc: Tom Rini <trini@kernel.crashing.org>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1116611802.12975.19.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050519164323.GK3771@smtp.west.cox.net>
	 <1116573175.7647.4.camel@dhcp-188.off.vrfy.org>
	 <20050520171808.GM3771@smtp.west.cox.net>
	 <1116611802.12975.19.camel@dhcp-188>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> 
> Well, it doesn't depend on "make it private" it depends on Dimitry, who
> wanted to tweak our patch for the input layer. But we wait for weeeks
> for that. The SUSE kernel already ships a driver-core input layer
> without the /sbin/hotplug stuff.
>

Kay,

I am sorry for being slow with these patches but I really do spend all
time that I can on kernel. Unfortunately, there are also other input
problems (KVMs causing mice lose sync), and since BK is gone and there
is a big backlog of input patches in Vojtech's tree I am unable to get
patches easily in mm. I was thinking about creating a git tree or a
quilt export but I don't have a place to host them ;(

-- 
Dmitry
