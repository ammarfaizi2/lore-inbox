Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274894AbRIZJfB>; Wed, 26 Sep 2001 05:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274896AbRIZJev>; Wed, 26 Sep 2001 05:34:51 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:61957 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274894AbRIZJee>; Wed, 26 Sep 2001 05:34:34 -0400
Date: Wed, 26 Sep 2001 10:49:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 problems with X + USB mouse
Message-ID: <20010926104954.B1651@suse.cz>
In-Reply-To: <20010923222036.A1685@taral.net> <20010923233022.A30991@lnuxlab.ath.cx> <20010925204047.A2818@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925204047.A2818@srcf.ucam.org>; from mjg59@srcf.ucam.org on Tue, Sep 25, 2001 at 08:40:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 08:40:47PM +0100, Matthew Garrett wrote:

> On Sun, Sep 23, 2001 at 11:30:22PM -0400, khromy wrote:
> 
> > I had this problem too.  I used NetMousePS/2 in XF86Config but changing
> > it to IMPS/2 fixed it.
> 
> Here too. Using IMPS/2 appears to have the disadvantage that the side 
> buttons are only recognised as duplicates of buttons 2 and 3, whereas 
> NetmousePS/2 allowed all of them to be used separately.

NetmousePS/2 is no longer supported, because it was problematic (on X
and GPM side). Use ExplorerPS/2 instead for 5 button support.

-- 
Vojtech Pavlik
SuSE Labs
