Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKRHCN>; Sat, 18 Nov 2000 02:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbQKRHBv>; Sat, 18 Nov 2000 02:01:51 -0500
Received: from [216.161.55.93] ([216.161.55.93]:34552 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129091AbQKRHBn>;
	Sat, 18 Nov 2000 02:01:43 -0500
Date: Fri, 17 Nov 2000 22:31:37 -0800
From: Greg KH <greg@wirex.com>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 still very broken
Message-ID: <20001117223137.A26341@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, David Ford <david@linux.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <8v4306$sga$1@cesium.transmeta.com> <3A161337.6A1BE826@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A161337.6A1BE826@linux.com>; from david@linux.com on Fri, Nov 17, 2000 at 09:27:19PM -0800
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 09:27:19PM -0800, David Ford wrote:
> 
> The second issue is usb.  I now have two machines that lockup on boot in USB.
> One is the above workstation, the second is a Compaq laptop.  Unfortunately
> I have no way of unplugging the USB hardware inside the laptop :P

Can't you not compile in the UHCI driver?  Actually, it seems odd that a
Compaq laptop would have a uhci driver, as Compaq was one of the OHCI
creators...

greg k-h


-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
