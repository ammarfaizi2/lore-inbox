Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSEUSEl>; Tue, 21 May 2002 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEUSEk>; Tue, 21 May 2002 14:04:40 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:54533 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315335AbSEUSEj>;
	Tue, 21 May 2002 14:04:39 -0400
Date: Tue, 21 May 2002 11:03:44 -0700
From: Greg KH <greg@kroah.com>
To: Martin Devera <devik@cdi.cz>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Oops report USB-OHCI
Message-ID: <20020521180344.GE1295@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0205211644080.12674-200000@luxik.cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 15:02:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 04:48:35PM +0200, Martin Devera wrote:
> The Oops from ksymoops is attached. There is one warning
> but the System.map was correct (I tested twice).
> The problem is repetable - I tested on 3 computers. It occured
> with two types of phillips camera and with modem.
> On UHCI it works, with OHCO - Opti chipset is fails.
> Kernel 2.4.18, no patches. Tested on Pentium and PII computers.
> There is
> kernel BUG at usb-ohci.h:464!
> always before Oops. It seems definitely to be bug in kernel.
> Probably TD/ED memory is freed twice ..

Does this problem also happen on 2.4.19-pre8?

thanks,

greg k-h
