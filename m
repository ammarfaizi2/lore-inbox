Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVGMNZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVGMNZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVGMNZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 09:25:33 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:15261 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262613AbVGMNZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 09:25:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=V8YH2CTSAPaPxTckxv9R+zSlrA50fHzdObFaM+u2fZZol5oKNK1u5r4veYTH7e/Q10/F4E3h0TG0B6S7ENfeMTeVpnTFngG6TTwSCx9esnnzbzgh6QMFSQ8dFZzTi0fahD/S/Boc18VcY3pK04rxjTM5ljZEonEeYGJlzbKsRtA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [stable] [patch 1/1] uml: fix TT mode by reverting "use fork instead of clone"
Date: Wed, 13 Jul 2005 15:33:00 +0200
User-Agent: KMail/1.8.1
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050712172838.271E8D9A84@zion.home.lan> <20050712185023.GY19052@shell0.pdx.osdl.net>
In-Reply-To: <20050712185023.GY19052@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131533.00817.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 20:50, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > Revert the following patch, because of miscompilation problems in
> > different environments leading to UML not working *at all* in TT mode; it
> > was merged lately in 2.6 development cycle, a little after being written,
> > and has caused problems to lots of people; I know it's a bit too long,
> > but it shouldn't have been merged in first place, so I still apply for
> > inclusion in the -stable tree. Anyone using this feature currently is
> > either using some older kernel (some reports even used 2.6.12-rc4-mm2) or
> > using this patch, as included in my -bs patchset.

> > For now there's not yet a fix for this patch, so for now the best thing
> > is to drop it (which was widely reported to give a working kernel).

> And upstream will leave this in, working to real fix?
Preferably yes, but this depends on whether the fix is found. Otherwise this 
exact patch will be merged upstream too.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
