Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSFTWG1>; Thu, 20 Jun 2002 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSFTWG0>; Thu, 20 Jun 2002 18:06:26 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:21008 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315856AbSFTWG0>;
	Thu, 20 Jun 2002 18:06:26 -0400
Date: Thu, 20 Jun 2002 15:05:00 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCHlet] 2.5.23 usb, ide
Message-ID: <20020620220459.GH1470@kroah.com>
References: <3D120BCB.8080701@pacbell.net> <UTC200206201849.g5KInaK27367.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200206201849.g5KInaK27367.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 23 May 2002 20:28:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:49:36PM +0200, Andries.Brouwer@cwi.nl wrote:
> Now that you tell me that these things are set at initialization
> and never changed, the initialization must be wrong. And indeed,
> it says "__devexit_p(uhci_stop)" and this yields NULL.
> 
> So, my previous stopoops patch can be replaced by

<snip>

Yes, that's a correct patch.  I've added it to my tree, thanks.

greg k-h
