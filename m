Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSEWWZI>; Thu, 23 May 2002 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317027AbSEWWZH>; Thu, 23 May 2002 18:25:07 -0400
Received: from pc-62-31-74-121-ed.blueyonder.co.uk ([62.31.74.121]:14981 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317024AbSEWWZH>; Thu, 23 May 2002 18:25:07 -0400
Date: Thu, 23 May 2002 23:25:04 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020523232504.A1664@redhat.com>
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost> <20020523011144.GA4006@matchmail.com> <20020523094948.A2462@redhat.com> <001701c20269$67d48dc0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 23, 2002 at 08:52:04AM -0600, Herman Oosthuysen wrote:
 
> Does this mean that Ext3 is still not recommended for use with RAID1?

On 2.2, yes.  On 2.4, it should work just fine: the 2.4 raid layer is
much better behaved, and does not try to perform resync via the buffer
cache.

Cheers,
 Stephen
