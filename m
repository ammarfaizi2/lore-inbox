Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCKQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCKQLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCKQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:10:49 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:20366 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261218AbVCKQKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:10:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Sn4Kr9iKIPk06E+IpYER5E4pGIYXq6cyW5ujogGOQnouqUcG279X/j0f0rljlZnQbRS6trzLdAJswb7WSACRs6zhwZrz/TfgQX0a6UqBsSQcTOXty3apFcMAC9gSMZgctNqnwDSUIjQtPJM+gycakj0fJltgxqbQ3AXumALh3t4=
Message-ID: <9e47339105031108102e0e4e60@mail.gmail.com>
Date: Fri, 11 Mar 2005 11:10:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: binary drivers and development
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423082BF.6060007@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 12:24:15 -0500, John Richard Moser
<nigelenki@comcast.net> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've done more thought, here's a small list of advantages on using
> binary drivers, specifically considering UDI.  You can consider a
> different implementation for binary drivers as well, with most of the
> same advantages.

Think about the impact the evolution of devfs and sysfs have on the
driver model. They are still evolving. Or the 32 to 64 bit impact on
ioctl's.

-- 
Jon Smirl
jonsmirl@gmail.com
