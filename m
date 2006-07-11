Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWGKTef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWGKTef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGKTef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:34:35 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:34264 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751205AbWGKTee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:34:34 -0400
Date: Tue, 11 Jul 2006 21:34:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711193423.GA9685@mars.ravnborg.org>
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org> <20060711173301.GA27818@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060711173301.GA27818@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:33:01PM +0100, Christoph Hellwig wrote:
> On Tue, Jul 11, 2006 at 05:28:43PM +0100, David Woodhouse wrote:
> > It would be nice in the general case if we could actually _compile_ each
> > header file, standalone. There may be some cases where that doesn't
> > work, but it's a useful goal in most cases, for bother exported headers
> > _and_ the in-kernel version. For the former case it would be nice to add
> > it to 'make headers_check' once it's realistic to do so.
> 
> That would be extremly valueable.  Maybe one of the kbuild gurus could
> cook up a make checkheaders rule that does this?
JÃrn Engel IIRC created a perl scrip that did this a year or two ago.
Try googling a bit.

	Sam
