Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVACQyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVACQyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVACQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:54:24 -0500
Received: from mx.freeshell.org ([192.94.73.21]:43759 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261497AbVACQyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:54:21 -0500
Date: Mon, 3 Jan 2005 16:54:10 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: dtor_core@ameritech.net
cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <d120d50005010308355783c996@mail.gmail.com>
Message-ID: <Pine.NEB.4.61.0501031648260.29960@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> 
 <200501022206.50265.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501030536110.14662@sdf.lonestar.org>
  <200501030123.58884.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501031317110.15363@sdf.lonestar.org>
 <d120d50005010308355783c996@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Dmitry Torokhov wrote:

>> [snip]
>
> That is even wierdier. The keyboard controller does not respond to the
> most basic command. I have seen one report of this happening
> (http://bugme.osdl.org/show_bug.cgi?id=3830) but acpi=off helped in
> that case. I wonder, when you tried acpi=off, did you power off your
> box or just rebooted?

I rebooted with the 'reboot' command.

> The big input update went in with 2.6.9-rc2-bk4. Could you please try
> bk3 and bk4 to verify that this update is causing the problems or we
> shoudl look elsewhere.

This problem happened for me with 
2.6.9-final as well. I will try with rc2-bk3 and bk4 and keep you posted.

By the way, this box runs Debian 
SID, and SID's own kernel 2.6.9-amd64 image resets the system before it 
gets to the module-loading stage (how weird!)


- Roey
