Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWBRNw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWBRNw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBRNw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:52:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751263AbWBRNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:52:27 -0500
Date: Sat, 18 Feb 2006 13:52:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Michlmayr <tbm@cyrius.com>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060218135224.GA2904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Michlmayr <tbm@cyrius.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <20060210235654.GA22512@kroah.com> <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org> <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com> <20060218120617.GA911@infradead.org> <20060218133715.GA8422@unjust.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218133715.GA8422@unjust.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:37:15PM +0000, Martin Michlmayr wrote:
> * Christoph Hellwig <hch@infradead.org> [2006-02-18 12:06]:
> > > It would be nice to have one place to go to find burners, and to have
> > > the model information in that place.
> > /proc/sys/dev/cdrom/info
> 
> Nice.  Is that a stable interface people can rely on (seems this me it
> should rather be in sys)?  I maintain a tool in Debian to rip/encode
> audio CDs with one command and we could use this file to find the CD
> interface if it's not specified by the user.

I think it's pretty stable.  Except for adding new capabilities it's been
unchanged since the 2.2.x days.

Maybe Jens can comment more on it?
