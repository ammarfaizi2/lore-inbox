Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269934AbRHJPwB>; Fri, 10 Aug 2001 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269936AbRHJPvw>; Fri, 10 Aug 2001 11:51:52 -0400
Received: from archive.osdlab.org ([65.201.151.11]:133 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S269934AbRHJPvl>;
	Fri, 10 Aug 2001 11:51:41 -0400
Message-ID: <3B740216.FD13A444@osdlab.org>
Date: Fri, 10 Aug 2001 08:47:34 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: satish kumar <satish_shak@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How vendor specific drivers communicate
In-Reply-To: <20010810050402.24532.qmail@web20302.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

satish kumar wrote:
> 
> Hi,
> 
>   Please tell me , where can i get the complete
> scenerio of, how the vendor specific driver (composite
> device )communicate with USB drivers present in Linux.

Hi-

I think that you would get better answers by asking
your questions on linux-usb-devel@lists.sourceforge.net .

See http://www.linux-usb.org for some information, such as
the Linux-USB User's Guide and the Linux-USB Programming Guide.
For anything more than that, you'll probably need to ask
more specific questions.

In general, USB devices are handled at their interface
level, so if a USB device presents multiple USB
"interfaces," then a separate driver can communicate
to each interface.

-- 
~Randy
