Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSANDM2>; Sun, 13 Jan 2002 22:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288184AbSANDMS>; Sun, 13 Jan 2002 22:12:18 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:13579 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288173AbSANDMM>;
	Sun, 13 Jan 2002 22:12:12 -0500
Date: Sun, 13 Jan 2002 19:09:04 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cleanup file.h and INIT_TASK a bit
Message-ID: <20020114030904.GA16849@kroah.com>
In-Reply-To: <20020113185947.A32700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020113185947.A32700@redhat.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 17 Dec 2001 00:52:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 06:59:47PM -0500, Benjamin LaHaise wrote:
> 
> Oh, the file.h cleanup exposed a mess (bug): usb.c was duplicating code 
> from daemonize().

That's drivers/usb/storage/usb.c, the usb-storage driver's file.  Which
should not be confused with drivers/usb/usb.c  :)

greg k-h
