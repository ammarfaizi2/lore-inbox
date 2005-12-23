Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVLWAwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVLWAwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLWAwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:52:44 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:51193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbVLWAwn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:52:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K9g5gLh5HXBWNE1cu5cZUPqT7nj6f/CIZGgW44qedAKhf5Ja4nvUdz5SmvRoXlfkZ2IBfMKQVPSysVR3G+2HSM8v9obGCr+eujvnZZsGWogcaPz5xkQK2bF6I0dA7qAGICZl7Eat7X0Pp/J/5gPEDKTCduTLMiW3uQF/nGoMd4A=
Message-ID: <9929d2390512221652o759bcce8k711143db5c7d6644@mail.gmail.com>
Date: Thu, 22 Dec 2005 16:52:41 -0800
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Tim Warnock <timoid@getonit.net.au>
Subject: Re: FW: Kernel oops v2.4.31 in e1000 network card driver.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C67FBCB411B4024382B11B96D68E49E407968C@server.local.GetOffice>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <C67FBCB411B4024382B11B96D68E49E407968C@server.local.GetOffice>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/05, Tim Warnock <timoid@getonit.net.au> wrote:
> Further information to this:
>
> Network card causing the problem is the intel quad port gigabit ethernet
> pci card.
> I have tested also on 2.4.27, 2.4.32 and the latest 2.6 series kernel.
>
> Under load (10-15kpps) the network driver crashes. Under increased load
> (20-30kpps) the driver will actually cause a full kernel panic and
> reboot the box.

What driver version are you using?
Can you provide the output from `lspci -vvv`



--
Cheers,
Jeff
