Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJSTZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJSTZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:25:13 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:46037 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262186AbTJSTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:25:07 -0400
Subject: Re: kernel-2.6.0-test{7-8} and radeon drm segfault
From: Louis Garcia <louisg00@bellsouth.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031019132536.GF8018@redhat.com>
References: <1066518605.4195.11.camel@tiger>
	 <20031019132536.GF8018@redhat.com>
Content-Type: text/plain
Message-Id: <1066591516.3077.9.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Sun, 19 Oct 2003 15:25:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmesg had no opps at all. I did get this response from the dri mailing
list.

> I have similar problen on Rage128. I looked at it for a little
> while. I think it may have something to do with the threading
> changes RH is putting > into their copy of XFree. 
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=105581


--Louis

On Sun, 2003-10-19 at 09:25, Dave Jones wrote:
> On Sat, Oct 18, 2003 at 07:10:05PM -0400, Louis Garcia wrote:
>  > I've been playing with kernel-2.6 on redhat's latest beta. With my
>  > radeon 7500 drm works great. When I boot to kernel-2.6 latest, I
>  > modprobe agpgart, intel-agp and radeon. Startx and run glxinfo
>  > and glxgears and both segfault. Anyone else seeing this? This
>  > also happens if these are build statically.
> 
> Check dmesg after they segfault, there may be a kernel oops
> in there.
> 
> 		Dave

