Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVCPXUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVCPXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVCPXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:19:46 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:26780 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261689AbVCPXQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:16:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qeTioScWOThnEHmuK2qe2kAmvXpGsPuubOWAMOAv5wlspCIX4kj9NqOdnjK6Z4wi7p6MAvWKQ+oZMuf5Tlq0oHqUeA/YKKimbWAyQUBDPsnKnGe1Y0QLzgHXI7qFgDS0WvmiRLRpBT/Qm3WR/TqAmZr/eA4mr9GXoinCNT5GDXQ=
Message-ID: <9e47339105031615163579ea50@mail.gmail.com>
Date: Wed, 16 Mar 2005 18:16:19 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changes to the driver model class code.
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050315170834.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 09:08:34 -0800, Greg KH <greg@kroah.com> wrote:
> Hi all,
> 
> There are 4 patches being posted here in response to this message that
> start us on the way toward cleaning up the driver model code so that
> it's actually usable by mere kernel developers :)

Is this going to let me make subdirectories in /sys/class/xxx
directories that generate hotplug events?

One example:
/sys/class/graphics/fb0/monitor(edid)

If the monitor is hotplugged the monitor directory will be
created/destroyed causing a hotplug event.

-- 
Jon Smirl
jonsmirl@gmail.com
