Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDQRNT>; Wed, 17 Apr 2002 13:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSDQRNS>; Wed, 17 Apr 2002 13:13:18 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:15633 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293132AbSDQRNQ>;
	Wed, 17 Apr 2002 13:13:16 -0400
Date: Wed, 17 Apr 2002 09:12:23 -0700
From: Greg KH <greg@kroah.com>
To: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change "return EBLAH" to "return -EBLAH in drivers/*
Message-ID: <20020417161223.GC374@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0204171223370.14274-100000@thor.cantech.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 12:59:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 12:42:23PM +0800, Anthony J. Breeds-Taurima wrote:
> Hello All,
> 	This is a simple patch that changes several "return EBLAH"'s in drivers/*
> for "return -EBLAH".  I have done my best to check the call stack to ensure
> that the change in sign of the return values wont break anything.

I'll add the usb driver changes to my tree, thanks.

Now if only those function return values were actually checked in the
code... :)

greg k-h
