Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRFVS4O>; Fri, 22 Jun 2001 14:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265487AbRFVS4E>; Fri, 22 Jun 2001 14:56:04 -0400
Received: from quattro.sventech.com ([205.252.248.110]:50959 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S265486AbRFVSzy>; Fri, 22 Jun 2001 14:55:54 -0400
Date: Fri, 22 Jun 2001 14:55:53 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Dylan Griffiths <Dylan_G@bigfoot.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Still some problems with UHCI driver in 2.4.5 on VIA chipsets
Message-ID: <20010622145553.W3715@sventech.com>
In-Reply-To: <3B2D446A.5C2AEEAC@bigfoot.com> <20010617200855.R9465@sventech.com> <3B2FBF76.40993998@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B2FBF76.40993998@bigfoot.com>; from Dylan_G@bigfoot.com on Tue, Jun 19, 2001 at 03:09:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001, Dylan Griffiths <Dylan_G@bigfoot.com> wrote:
> Johannes Erdfelt wrote:
> > Could you load uhci with the debug=1 option?
> 
> I did an 'insmod uhci.o debug=1' but the dmesg output did not alter.
> 
> My easy steps to reproduce it is to 'delete selected images' in gphoto such
> that there will be no images in the camera left when the operation is done. 
> At loast it doesn't lock up the camera like it used to :-/
> 
> I think this may be a problem in the dc2xx.o then, since uhci didn't reveal
> any new messages.

It's possible. Many cameras are touchy wrt to the commands it receives.
If one is slightly wrong, some of them will just stop talking.

Did you try with the usb-uhci driver as well?

JE

