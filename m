Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288060AbSACAch>; Wed, 2 Jan 2002 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288081AbSACAbJ>; Wed, 2 Jan 2002 19:31:09 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:19726 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288063AbSACA3a>;
	Wed, 2 Jan 2002 19:29:30 -0500
Date: Wed, 2 Jan 2002 16:28:27 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020103002827.GA4462@kroah.com>
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33A4EC.1040300@videotron.ca>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 22:24:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 07:25:16PM -0500, Roger Leblanc wrote:
> Greg KH wrote:
> >
> >Have you unloaded your scanner module before unloading the usb-uhci
> >module?
> >
> No. Actually, I don't even know how it's called. How can I find out?

I think it's called "scanner".  Just look for any module that the
usbcore module shows as "Used by".

greg k-h
