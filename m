Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUKSIMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUKSIMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbUKSIMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:12:30 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:4774 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261201AbUKSIM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:12:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J5tJL+TM7azSkFvCYC1WErsAPQ4CyydHh9eO8J4ThLw/+yG0hvhrFUTENdBRxmPNm/+MrlnuiP5KVlyrv3cTW20mIksxY4yyV5lvHBsD5FRgVZW/aMQMSheEq7OnW3n5/L7bK8ADwzoCV+cNVVMVvhoPeigozytGECXBZCCOPdw=
Message-ID: <21d7e9970411190012a2d1f34@mail.gmail.com>
Date: Fri, 19 Nov 2004 19:12:27 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Ralf Gerbig <rge@quengel.org>
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt)
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970411182348704d2f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <87lld0rb2i.fsf-news@hsp-law.de>
	 <20041117110640.1c7ccccd.akpm@osdl.org>
	 <87actgt8zy.fsf-news@hsp-law.de> <87sm76q40b.fsf-news@hsp-law.de>
	 <21d7e9970411182348704d2f0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > investigating further, radeon.ko nukes the NIC / INT
> >
> 

btw I'm running 2.6.10-rc1 on my machine with a shared radeon IRQ no problems,
 11:    2542086          XT-PIC  uhci_hcd, uhci_hcd, eth0,
radeon@pci:0000:01:00.0

I'll see if I can get time to grab Andrews tree over the weekend and
build it locally....

Dave.
