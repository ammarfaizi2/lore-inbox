Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbTCYBh2>; Mon, 24 Mar 2003 20:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCYBhV>; Mon, 24 Mar 2003 20:37:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:28688 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261345AbTCYBhI>;
	Mon, 24 Mar 2003 20:37:08 -0500
Date: Mon, 24 Mar 2003 17:47:44 -0800
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325014744.GA11386@kroah.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de> <20030325003048.GC10505@kroah.com> <20030325021825.4f0e67e4.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325021825.4f0e67e4.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 02:18:25AM +0100, Udo A. Steinberg wrote:
> On Mon, 24 Mar 2003 16:30:48 -0800 Greg KH (GK) wrote:
> 
> GK> Yes, I sent out some patches a few evenings ago to lkml that should fix
> GK> this problem.  I'm resyncing them with 2.5.66 right now and will send
> GK> them to Linus in a bit.
> 
> I've found all 13 patches and applied them here.
> 
> GK> If you want to get around this for now, in the bttv driver, memset the
> GK> i2c_client structure to 0 after it is initialized.  That will solve the
> GK> problem.
> 
> Yes, the oops is cured now.

Great, thanks for letting me know.

greg k-h
