Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSIDXG2>; Wed, 4 Sep 2002 19:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSIDXG2>; Wed, 4 Sep 2002 19:06:28 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:29199 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315946AbSIDXGZ>;
	Wed, 4 Sep 2002 19:06:25 -0400
Date: Wed, 4 Sep 2002 16:09:01 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: mdharm-kernel@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020904230901.GA8574@kroah.com>
References: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 12:56:00AM +0200, Andries.Brouwer@cwi.nl wrote:
> >> Matt, is it ok with you for me to add this patch to the tree?
> 
> > I'd like to hold off a few more days while I try to find out what the
> > 'secret sauce' that the other OSes use for a device like this.
> 
> Hmm. You do not confuse two situations, do you?
> In the past few days I made two devices work.
> 
> One was a Feiya 5-in-1 CF / SM / SD card reader
> (Vendor Id: 090c, Product Id: 1132, Revision 1.00).
> It returned a capacity that is one too large, and becomes
> very unhappy if one tries to read a sector past the end.
> So, a flag was needed to tell that the result of READ CAPACITY
> needs fixing.

Seems reasonble, Matt, any objection?

> The other was a Travelmate CF / SM / SD card reader
> (Vendor Id: 3538, Product Id: 0001, Revision 2.05).
> It became unhappy when MODE_SENSE asked for too much data.
> A patch on sd.c solved this.

Linus already added this patch to his tree :)

thanks,

greg k-h
