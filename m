Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVKTPIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVKTPIu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVKTPIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:08:50 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:23738 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751245AbVKTPIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:08:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=R5w7+ceo3c9d4hloc7KsBM0TAqraD3OmOM4B2jmDRIpHarFbX8u3EQ8Z2u6Y7IhMb3es6VcQi3aV1Piic9BVpnLWfHRobVN8qPBpcumrqZXJjTn26d1/Cu2vVuXgkfc/hyU+u5A1pir2Ag0eLj5tNuuZ6hG/TmrNBByj8tI5bWM=
Date: Sun, 20 Nov 2005 18:22:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Anders Peter Fugmann <afu@fugmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forcedeth probems using linux 2.6.15-rc1
Message-ID: <20051120152253.GA19364@mipter.zuzino.mipt.ru>
References: <437A3672.9000002@fugmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A3672.9000002@fugmann.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:26:42PM +0100, Anders Peter Fugmann wrote:
> The forcedeth driver occasionally hangs, sometimes after several hours,
> sometimes after just a few minutes of traffic. Hardware is a Nvidia NForce3
> motherboard with onboard LAN
> (Linux compiled for 64 bit, using gcc 4.0.3 prerelease). Removing and
> inserting resolves to problem for
> a short period of time. The driver works without complaints on Linux 2.6.14.
>
> The following is being printed to the kernel logs repeatably:
>
> Nov 14 22:12:32 gw kernel: NETDEV WATCHDOG: eth1: transmit timed out

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugzilla.kernel.org/show_bug.cgi?id=5632

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

