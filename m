Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWARLME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWARLME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWARLME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:12:04 -0500
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:37478 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030220AbWARLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:12:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ELOZAUGNDS8oA74uDgZNwLaw3vqO4tDnkgLoRQOV3IPJAzGeVcaH/dzyOhZN7Yxr+msCqizOcRa1YMaAHSizdr6TFqOzu1oxbKXLobdlu7OTRmEXI81bcl8ql796hL8HqJmOBXSTzmJR4TzScUpn1Z5dlYKMr3qFsWQ+Em4Er4k=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Date: Wed, 18 Jan 2006 12:11:49 +0100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060117235659.14622.18544.stgit@zion.home.lan> <20060118001920.14622.79573.stgit@zion.home.lan> <20060118025354.GA13825@ccure.user-mode-linux.org>
In-Reply-To: <20060118025354.GA13825@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181211.50190.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 03:53, Jeff Dike wrote:
> On Wed, Jan 18, 2006 at 01:19:21AM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Done by Jeff around January for ubd only, later lost, then restored in
> > his tree - however I'm merging it now since there's no reason to leave
> > this here.
>
> The original was dinged by hch for covering over a problem without really
> fixing it.
>
> We need to think about this one some more.

About this, have you reported upstream the "crash with remove ubd2 and ubd3" 
thing caused by wrong refcounts? Greg and friends tend to fix various drivers 
all around, I guess it's the right policy to ask them to fix this too.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
