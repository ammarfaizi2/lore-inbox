Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCWGrg>; Fri, 23 Mar 2001 01:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRCWGr0>; Fri, 23 Mar 2001 01:47:26 -0500
Received: from adsl-63-200-41-38.steelrain.org ([63.200.41.38]:29199 "EHLO
	thor.sbay.org") by vger.kernel.org with ESMTP id <S129638AbRCWGrO>;
	Fri, 23 Mar 2001 01:47:14 -0500
Date: Thu, 22 Mar 2001 22:43:21 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Woller, Thomas" <twoller@crystal.cirrus.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
In-Reply-To: <E14gCbN-0003Kn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103222238001.994-100000@batman.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alan Cox wrote:

> This is commonly done using the speedstep feature on intel cpus. Speedstep
> can generate events so the OS knows about it but Intel are not telling
> people about how this works.
<...snip...>
> We certainly could recalibrate the clock if we could get events out of
> ACPI, APM or some other source.

Specific events for Speedstep on/off would be nice, but in practice, can
we re-calibrate when ever there is a change in the power status (on
battery, charging, etc.)?

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/

