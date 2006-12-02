Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424321AbWLBSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424321AbWLBSNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424322AbWLBSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:13:54 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:32883 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1424321AbWLBSNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=uU0HYKNcbd6uOwSLv/X9vYdrVqotijOkL/6rhmQCa6WQrD6Vdctj+o/lrLqPE3QeGxAKP5R+lb+FrmUTVDlSGUDqzzmmCvZDKM+MJJGhTCrZVITHLs6NPWxTvPK0eo/Z2rxcB0NHy3e7g6emNu7qQltuJpKj40HP3YWHZEtghK0=  ;
X-YMail-OSG: X1Y3IUIVM1kl7dR9zK8aIA5revMJUkdLYyChUeUfmLAH8U.4Scf6Gz7bIT6mJra6iiZXB7vA90NsjL2qn.UNTFJOH63sOWAfVq47Zr5Jncz2e5lS.otyaA--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: rtc-ds1307 driver (especially for DS1337, DS1339)
Date: Sat, 2 Dec 2006 10:13:49 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
       eibach@gdsys.de, stieler@gdsys.de, Jean Delvare <khali@linux-fr.org>,
       James Chapman <jchapman@katalix.com>,
       Bill Gatliff <bgat@billgatliff.com>
References: <20061202145512.3baccf92@inspiron>
In-Reply-To: <20061202145512.3baccf92@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021013.50425.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 December 2006 5:55 am, Alessandro Zummo wrote:
> 
>  Hello,
> 
>  given the recent patch for ds1337 initialization (drivers/i2c/chips),
>  I would like to ask owners of DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00
>  to give a try the rtc-ds1307 driver (drivers/rtc).
> 
>  I need to be sure that it works (and correctly initializes)
>  all the chips that claims to support.

Unless it's broken _recently_ we already have confirmation that rtc-1307
works for DS1307 and M41T00, so it's the other chips that would be most
interesting ...


>   Jean would be very happy if we can remove drivers from
>  i2c/chips ;)

I think the ds1337.c driver could vanish if we had confirmation that
the ds1307 driver also works on the DS1337 and DS1339 ... so, special
thanks if you can confirm it with those chips.  Chip docs say they
are compatible, so far as the driver is concerned.

- Dave
