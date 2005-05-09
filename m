Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVEIGp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVEIGp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVEIGp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:45:29 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:50365 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263063AbVEIGpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:45:23 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up on A7M266-D
Date: Mon, 9 May 2005 02:45:05 -0400
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>,
       Shawn Starr <shawn.starr@rogers.com>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com> <20050507082548.GA18700@infradead.org> <427CC24F.9010304@suse.de>
In-Reply-To: <427CC24F.9010304@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505090245.05662.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, it makes sense, normally you won't find SCSI on desktops so why bother 
with suspend. I don't know if the cards can do it or not, since they need 
their firmware loaded at driver init. The firmware would need to be modified 
to support such state?

Shawn.

On May 7, 2005 09:27, Stefan Seyfried wrote:
> Christoph Hellwig wrote:
> > On Fri, May 06, 2005 at 11:34:02PM +0200, Stefan Seyfried wrote:
> >> Known, XFS was broken / breaking wrt suspend. Pavel fixed this with the
> >> XFS guys IIRC and i think those patches were on lkml also, but am not
> >> sure. => this should work soon.
> >
> > Pavel's fix wasn't enough.
>
> That's what i wanted to tell with "...with the XFS guys..." :-)
>
> > The fix that has been verified to work is
> > in 2.6.12-rc4.
>
> Ok, i only knew there was something in the works.
>
> > qla1280 doesn't handle suspend/resume indeed.
>
> As almost all SCSI stuff, which is no surprise to me since suspend /
> resume seem rather uncommon on servers where SCSI is mostly used today
> ;-) I was more baffled to find out that the brand new SATA drivers had
> no suspend support.
