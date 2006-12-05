Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968031AbWLEC2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968031AbWLEC2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 21:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968033AbWLEC2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 21:28:11 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:24990 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968031AbWLEC2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 21:28:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IkATWXBJYU5L+sD9MgiEnGJBOOwQFGfxOsaAFkpbBIg2LOEso4vU3pPrjCD9nKTzw7BDhOZ4CWfVTXPiYJNVH0DhJ4niqHrz2CX3aJ53iUmYAMRNxy3pUeRtXMqAm1I55nqrRRzjsNG5WcBnJTvHe9ATFm/u8NBuxVeoNQL5nDM=  ;
X-YMail-OSG: 1a.IRsQVM1ksIbY0JcH_aggKSouNFEGIOaYQh28j1t.2x32O2Dufdi_lLEKO7P8CwlsXqakOgbcE4U7OZSF9NF4uEgCNXnNSLPBP_RW9B3wkMAJD1.Ef2w--
From: David Brownell <david-b@pacbell.net>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [2.6 patch] USB_RTL8150 must select MII
Date: Mon, 4 Dec 2006 16:53:54 -0800
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, dbrownell@users.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <20061204200206.GA7027@stusta.de> <20061204151324.15288113.randy.dunlap@oracle.com>
In-Reply-To: <20061204151324.15288113.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612041653.55618.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 3:13 pm, Randy Dunlap wrote:
> On Mon, 4 Dec 2006 21:02:06 +0100 Adrian Bunk wrote:
> 
> > USB_RTL8150 must select MII to avoid link errors.
> > 
> > Stolen from a patch by Randy Dunlap.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Thanks, Adrian.
> 
> David B. may prefer a patch similar to the one that was
> merged for USB_NET_MCS7830, which does:
> 
> 	select USB_USBNET_MII

No, rtl8150 doesn't use the usbnet framework.
