Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVACQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVACQfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVACQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:35:31 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:53535 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVACQfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NVhIr2GlJMX/hNr+CAyd/mZehSys71V2Ls8d6BODV2qIb1+bQSWCiLcLv0/DBif7bxUT9fygVLXidZiUW6IplWT++LZFq3zgS2tB8w7D2n2HrAwNBxcCrbSr5nht343B8+pWssK0YA+a2G/dkrWzc5B9g/MJ1yvZY6Up3VM6pO8=
Message-ID: <d120d50005010308355783c996@mail.gmail.com>
Date: Mon, 3 Jan 2005 11:35:25 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Roey Katz <roey@sdf.lonestar.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <Pine.NEB.4.61.0501031317110.15363@sdf.lonestar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
	 <200501022206.50265.dtor_core@ameritech.net>
	 <Pine.NEB.4.61.0501030536110.14662@sdf.lonestar.org>
	 <200501030123.58884.dtor_core@ameritech.net>
	 <Pine.NEB.4.61.0501031317110.15363@sdf.lonestar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005 13:21:02 +0000 (UTC), Roey Katz
<roey@sdf.lonestar.org> wrote:
> Dmitry,
> 
> kernel bootup, syslog and dmesg outputs are here:
> 
>   http://roey.freeshell.org/mystuff/kernel/
> 
> all end in "-20050103"
> 
> This is with "acpi=off" as you instructed.
>

That is even wierdier. The keyboard controller does not respond to the
most basic command. I have seen one report of this happening
(http://bugme.osdl.org/show_bug.cgi?id=3830) but acpi=off helped in
that case. I wonder, when you tried acpi=off, did you power off your
box or just rebooted?

The big input update went in with 2.6.9-rc2-bk4. Could you please try
bk3 and bk4 to verify that this update is causing the problems or we
shoudl look elsewhere.

I am CCing Vojtech, maybe he has some ideas...

-- 
Dmitry
