Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRCMWdl>; Tue, 13 Mar 2001 17:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbRCMWdE>; Tue, 13 Mar 2001 17:33:04 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131163AbRCMWcP>;
	Tue, 13 Mar 2001 17:32:15 -0500
Message-ID: <3AAE7406.283D2411@faceprint.com>
Date: Tue, 13 Mar 2001 14:24:54 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
In-Reply-To: <3AAE4DB6.8349ACBA@uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
> 
> Nathan Walp (faceprint@faceprint.com) wrote :
> 
> > Also, sometime between ac7 and ac18 (spring break kept me from testing
> > stuff inbetween), i assume during the new aic7xxx driver merge, the
> > order of detection got changed, and now the ide-scsi virtual host is
> > host0, and my 29160N is host1. Is this on purpose? It messed up a
> > bunch of my stuff as far as /dev and such are concerned.
> 
> SCSI adapters are enumerated randomly(*) , relying on certain numbering
> will get you into trouble, sooner or later.
> There is no commonly accepted solution, AFAIK.
> The same thing can happent to disk enumeration ( sdb becomes sdc )
> or partition enumeration ( hda6 becomes hda5 ).
> 
> * - theoreticaly no, but practicaly yes ( most of the time )
> 
> --
> David Balazic
> --------------
> "Be excellent to each other." - Bill & Ted
> - - - - - - - - - - - - - - - - - - - - - -

SCSI adapters are given host numbers in a random order?  Even with no
hardware changes?  Does this make less than sense to anyone else?  Every
kernel EVER up till now has had the real scsi cards (in some particular
order) then ide-scsi.  Have I just been lucky???

Nathan
