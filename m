Return-Path: <linux-kernel-owner+w=401wt.eu-S1751877AbXAPXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXAPXsd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbXAPXsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:48:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:58098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbXAPXsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:48:31 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NtwjZeAMSF1cFb3x7t7IyDQmKAZEpezSvM0flpnIyVRfEjSeX5fQ91olJzLi9EHDRRKc/kmkHEBUjBhPkxJw38vV6NG4MtAYDaZyhGV39X11LRntaGJlf3+XDTcVMd+0fTTfH3Bd7s+IybkTcggf52twmOs04+rWX00L2CWO2p8=
Message-ID: <2475a8740701161548v5758935dq51f1ed27a0c91d51@mail.gmail.com>
Date: Tue, 16 Jan 2007 15:48:28 -0800
From: "Sridhar Samudrala" <samudrala.sridhar@gmail.com>
To: "bert hubert" <bert.hubert@netherlabs.nl>,
       "Aurelien Jarno" <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Subject: Re: IPv6 router advertisement broken on 2.6.20-rc5
In-Reply-To: <20070116233053.GA667@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45AD46DD.7050408@aurel32.net>
	 <20070116233053.GA667@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the following patch

[IPV6] MCAST: Fix joining all-node multicast group on device initialization.
  http://www.spinics.net/lists/netdev/msg22663.html

that went in after 2.6.20-rc5 should fix this problem.

Thanks
Sridhar

On 1/16/07, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Tue, Jan 16, 2007 at 10:42:53PM +0100, Aurelien Jarno wrote:
>
> > I have just tried a 2.6.20-rc5 kernel (I previously used a 2.6.19 one),
> > and I have noticed that the IPv6 router advertisement functionality is
>
> Can you check if rc1, rc2, rc3 etc do work?
>
> Thanks.
>
> --
> http://www.PowerDNS.com      Open source, database driven DNS Software
> http://netherlabs.nl              Open and Closed source services
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
