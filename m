Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSGRQTm>; Thu, 18 Jul 2002 12:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318149AbSGRQTm>; Thu, 18 Jul 2002 12:19:42 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:518 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318252AbSGRQTl>;
	Thu, 18 Jul 2002 12:19:41 -0400
Date: Thu, 18 Jul 2002 09:21:21 -0700
From: Greg KH <greg@kroah.com>
To: Jacky Lam <sylam@emsoftltd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] USB lockup
Message-ID: <20020718162121.GE15037@kroah.com>
References: <1027003438.11402.5.camel@cm61-10-74-235.hkcable.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027003438.11402.5.camel@cm61-10-74-235.hkcable.com.hk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 20 Jun 2002 15:05:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 10:43:58PM +0800, Jacky Lam wrote:
> Dear all,
> 
> 	I experience an USB lockup since I upgrade my kernel from 2.4.19-pre6
> to 2.4.19-pre7. The problem seems to be caused by the correction of
> is_suspended variable initialsation in /driver/usb/uhci.c which may the
> suspend code actually runs. I don't know why my USB doesn't wake up
> after suspended. 
> 
> 	I have tested with 2.5.26 and all works fine.

Does 2.4.19-rc2 work ok?

thanks,

greg k-h
