Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290105AbSAKUh4>; Fri, 11 Jan 2002 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290107AbSAKUhq>; Fri, 11 Jan 2002 15:37:46 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:51717 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290105AbSAKUhh>;
	Fri, 11 Jan 2002 15:37:37 -0500
Date: Fri, 11 Jan 2002 12:34:55 -0800
From: Greg KH <greg@kroah.com>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Justin Pryzby <pryzbyj@clarkson.edu>, linux-kernel@vger.kernel.org
Subject: Re: USB UHCI compile error
Message-ID: <20020111203455.GA1579@kroah.com>
In-Reply-To: <Pine.GSO.4.10.10201102122080.28110-200000@crux.clarkson.edu> <20020111045718.GB26644@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111045718.GB26644@opeth.ath.cx>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 14 Dec 2001 18:21:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:57:18PM -0500, Dan Chen wrote:
> Compile in hotplug support as a workaround.
> 
> CONFIG_HOTPLUG=y
> CONFIG_HOTPLUG_PCI=y

You don't need CONFIG_HOTPLUG_PCI unless you have a pci hotplug
controller (most people do not.)

CONFIG_HOTPLUG=y should solve the problem for now.

greg k-h
