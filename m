Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVGCCaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVGCCaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 22:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVGCCaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 22:30:12 -0400
Received: from web51803.mail.yahoo.com ([206.190.38.234]:61835 "HELO
	web51803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261342AbVGCCaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 22:30:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nMZTN68NKzfc2K5ks3xcTZ8PrghaThD3VlPXkLsxRCC1wO21naofFFL7y5C/KoxIw6mKpQkKLNLDJDrqiCSsF222d9CzMUEyaq0zruXGJ1fqSV5Cr7Uc2luNBh5bC+Jg1F3esBz9F/l2X8QbLTv7nJAe1rrec1rztOB6+1UkC4g=  ;
Message-ID: <20050703022954.67178.qmail@web51803.mail.yahoo.com>
Date: Sat, 2 Jul 2005 19:29:54 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: ramdisk max size limitation?
To: kernel@crazytrain.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1120357030.3566.1.camel@crazytrain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I like tmpfs, but I can not export tmpfs.


Thanks for the help!



--- kernel <kernel@crazytrain.com> wrote:

> Phy,
> 
> mount tmpfs -t tmpfs -o size=600m /mnt/here
> 
> 
> Works for me on my 2.4.29 kernel.  600MB tmpfs.
> 
> 
> regards,
> 
> fd
> 
> On Sat, 2005-07-02 at 21:15, Phy Prabab wrote:
> > Hello,
> > 
> > Is there a limitation to the max size you can
> create a
> > ramdisk?  I have a 1.5G system and I am trying to
> > allocate a 1G RAM disk, yet no matter what I do,
> the
> > max I can create and use is 512M.  Is there a way
> to
> > get over this limitation?
> > 
> > Thanks for the help!
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> > http://mail.yahoo.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
