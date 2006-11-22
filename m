Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753182AbWKVHgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbWKVHgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbWKVHgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:36:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:5365 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753182AbWKVHgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:36:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LQ5C8ydtVmR4dgoCeCXJYjpiYMRDQKMa1020UYC5K/D35AdCh/IQ401qr7NUYemeGGBHee7a07uh8+ag509Dm4/rnc4Jk480Kn2oyRnX/B+JpmXXRBoLnoEd1/K/bC1qLfj7Hi2YHYEbez8uRUro9PcGlZBVuIqHaGD67oQhPOM=
Message-ID: <86802c440611212336n3a66a557mdf78ef0b6eac165a@mail.gmail.com>
Date: Tue, 21 Nov 2006 23:36:46 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH] Disable INTx when enabling MSI in forcedeth
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Daniel Barkalow" <barkalow@iabervon.org>, linux-kernel@vger.kernel.org,
       "David Miller" <davem@davemloft.net>,
       "Roland Dreier" <rdreier@cisco.com>,
       "Ayaz Abdulla" <aabdulla@nvidia.com>
In-Reply-To: <4563C775.8020004@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611212118540.20138@iabervon.org>
	 <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
	 <4563C775.8020004@garzik.org>
X-Google-Sender-Auth: 0374736b2df1e3b4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/06, Jeff Garzik <jeff@garzik.org> wrote:
> I agree.  And it's just a simple matter of remove the PCI-Express
> brackets AFAICS, like in the attached patch (untested).

How about if the ioapic is not inited for that card?

For example, I didn't initialize irq routing/ioapci for nvidia LAN.

YH
