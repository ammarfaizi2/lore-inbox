Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDTUgi>; Sat, 20 Apr 2002 16:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSDTUgh>; Sat, 20 Apr 2002 16:36:37 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:44553 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293457AbSDTUgg>;
	Sat, 20 Apr 2002 16:36:36 -0400
Date: Sat, 20 Apr 2002 12:35:08 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7-ac1 breaks my USB mouse
Message-ID: <20020420193508.GA18880@kroah.com>
In-Reply-To: <1019328673.873.5.camel@thanatos> <20020420182719.GA18580@kroah.com> <1019333233.1908.2.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 23 Mar 2002 17:32:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 04:07:05PM -0400, Thomas Hood wrote:
> The mouse doesn't work on 2.4.19-pre7 either.
> I reconfirmed that it does work on 2.4.19-pre5.

You don't have CONFIG_USB_HIDINPUT set, which you need to do.  You did
read the help for it when doing 'make oldconfig', right?  :)

Let me know if that fixes it for you.

thanks,

greg k-h
