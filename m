Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbSKQIYh>; Sun, 17 Nov 2002 03:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbSKQIYh>; Sun, 17 Nov 2002 03:24:37 -0500
Received: from uidc4-171.inav.uiowa.net ([64.6.85.246]:30854 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S267467AbSKQIYg>;
	Sun, 17 Nov 2002 03:24:36 -0500
Date: Sun, 17 Nov 2002 02:30:37 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 bug - USB usbfs segvs processes
Message-ID: <20021117083031.GB4280@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20021115174234.GB2828@digitasaru.net> <20021117004322.GD28824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021117004322.GD28824@kroah.com>
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Greg KH on Saturday, 16 November, 2002:
>On Fri, Nov 15, 2002 at 11:42:34AM -0600, Joseph Pingenot wrote:
>> /proc/bus/pci:58$ cat devices 
>> Segmentation fault
>You are trying to read /proc/bus/pci/* not /proc/bus/usb files.  So why
>would you think usbfs would have a problem?
>Also, a decoded oops report would help out a lot.

heh.  I *am* an ass.  That is indeed /proc/bus/pci, not /proc/bus/usb.
  Ewps.  lsusb *does* segv, although the fact that I was in the wrong
  directory is intriguing.  Maybe I'll get the same problem as I got
  with lsusb when trying lspci.  Hmm.

To my knowledge, there is no oops data.  I'll send more data when I get a
  chance to reboot into that kernel.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
"[The question of] copy protection has long been answered, and it's only
  a matter of months until more or less all CDs will be published with
  copy protection."  --"Ihr EMI Team" 
    http://www.theregister.co.uk/content/54/27960.html
