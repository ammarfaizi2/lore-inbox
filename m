Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWFMFlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWFMFlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbWFMFlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:41:51 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:35105 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752323AbWFMFlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:41:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nkc0PFNis3KTnJJgO1a2+Uj3AC6HaNStJ92BAih8QNXQ7hKk7S4inANxhYBZy1LYqFvvhnzJ9HBDyvtnReTSUOmisy9eBEbAM4vVui/yhLc6TL40GsWqgF6wCoaNRoryGRkE5BsZ0iM+itYi08jM2ptkwv3LNpFoq2DDbWVflyY=
Message-ID: <a44ae5cd0606122241nd24a83as9c4ff10d3539260b@mail.gmail.com>
Date: Mon, 12 Jun 2006 22:41:50 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060612105621.GA10887@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060608112306.GA4234@elte.hu> <20060610075954.GA30119@elte.hu>
	 <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
	 <20060611053154.GA8581@elte.hu>
	 <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
	 <20060612083117.GA29026@elte.hu>
	 <1150102041.24273.15.camel@imp.csi.cam.ac.uk>
	 <20060612094011.GA32640@elte.hu>
	 <1150107897.24273.25.camel@imp.csi.cam.ac.uk>
	 <20060612105621.GA10887@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.17-rc6-mm2-lockdep; fi
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko
needs unknown symbol lockdep_on
WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko
needs unknown symbol lockdep_off

Am I doing something wrong?
