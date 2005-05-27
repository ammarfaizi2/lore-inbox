Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVE0OAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVE0OAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVE0N7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:59:34 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:11960 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261449AbVE0N5H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:57:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PXLoUCgGZ84ORfWAZ19rn2TDG0v7vtcH6ePRwoMB9VQx5V8B8mFxzeTrwkcpCcp/iZSkRVxf5UqCgwO+0x/p5bmgMV2Y7GDoZq+qte0sZ91fi7QLa58//7hWbkv4Mw1Hp3qYLGSfD2xxgGCScUCl4MoVpk/Wg2Z0WRV+Jsq1Bzo=
Message-ID: <d120d50005052706571ad3d6a8@mail.gmail.com>
Date: Fri, 27 May 2005 08:57:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Subject: Re: mouse still losing sync and thus jumping around
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <42971978.3090500@shoden.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42271D67.4020300@shoden.co.za>
	 <20050525150713.3b3c2a09.akpm@osdl.org>
	 <42971978.3090500@shoden.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/05, Bennie Kahler-Venter <bennie.venter@shoden.co.za> wrote:
> Andrew Morton wrote:
> 
> >
> > Could you please retest 2.6.12-rc5?
> 
> Did test the kernel with both ACPI and APM enabled:
> 
> As you can see from dmesg.out there is till a sync loss.
> 

Could yo uplease try the following patch:

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v11.patch.gz

You will still see the messages but I expect mouse not jump like crazy
when it happens.

-- 
Dmitry
