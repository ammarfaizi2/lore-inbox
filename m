Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUELGVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUELGVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbUELGVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:21:42 -0400
Received: from findaloan.ca ([66.11.177.6]:33154 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S264993AbUELGMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:12:16 -0400
Date: Tue, 11 May 2004 09:34:28 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: Linux 2.6.6
Message-ID: <20040511133428.GA5635@mark.mielke.cc>
Mail-Followup-To: Tomas Szepe <szepe@pinerecords.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	len.brown@intel.com
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org> <20040510105129.GB25969@picchio.gall.it> <20040510204450.GA2758@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510204450.GA2758@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:44:50PM +0200, Tomas Szepe wrote:
> On May-10 2004, Mon, 12:51 +0200
> Daniele Venzano <webvenza@libero.it> wrote:
> > I have problems booting 2.6.6 (2.6.5 was fine). The boot stops at ide
> > detection, on cdrom probing, the last two messages I am seeing are:
> > ide-cd: cmd 0x5a timed out
> > hdc: lost interrupt
> This problem also affects my 2001 1.0 GHz Athlon box (VIA KT133a chipset).
> Len's final patch (proposed fix) from the "hdc: lost interrupt..." thread
> seems to work for me, too.

I was also affected by this - 1200 Mhz Athlon, VIA KT133 chipset as well.

I won't be trying Len's patch until tonight.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

