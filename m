Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbRFYSBL>; Mon, 25 Jun 2001 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265891AbRFYSBB>; Mon, 25 Jun 2001 14:01:01 -0400
Received: from mail.primacom.net ([62.208.91.33]:10216 "EHLO mail.primacom.net")
	by vger.kernel.org with ESMTP id <S265895AbRFYSAq>;
	Mon, 25 Jun 2001 14:00:46 -0400
Message-ID: <3B3798AC.C71DE3B6@evision.ag>
Date: Mon, 25 Jun 2001 22:01:48 +0200
From: Martin Dalecki <dalecki@evision.ag>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in 3c905 driver.
In-Reply-To: <3B378830.579A6DD@evision.ag> <20010625125418.A587@node0.opengeometry.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> 
> On Mon, Jun 25, 2001 at 08:51:28PM +0200, Martin Dalecki wrote:
> > Just a note...
> >
> > This card get's detected twofold by the plain 2.4.5 kernel.
> > It get's listed twice under both lspci and during the kernel boot
> > sequence on a HP LHr3 system.
> 
> I get only one message, I have 3c905CX and 2.4.5 kernel.  Maybe you have
> 2 cards inside? ;-)

Could you hand me your .config file over. Maybe there is something
sensitive
in the choices for PCI acess, Power management or not - or whatever else
it may be. I would like to confirm the true source of this error.
(Currently I'm guessing at a buggy compiler provided by SuSE or buggs
in the PCI setup code or some wired kind of BIOS configuration problem).
