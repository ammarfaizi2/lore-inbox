Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281457AbRKPQab>; Fri, 16 Nov 2001 11:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKPQaW>; Fri, 16 Nov 2001 11:30:22 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:20751 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281457AbRKPQaK>;
	Fri, 16 Nov 2001 11:30:10 -0500
Date: Fri, 16 Nov 2001 08:30:08 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Cc: Andrew Morton <akpm@zip.com.au>, hogsberg@users.sourceforge.net,
        jamesg@filanet.com, linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011116083008.C1308@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au> <3BEF27D1.7793AE8E@zip.com.au> <20011113191721.A9276@lucon.org> <3BF21B79.5F188A0D@zip.com.au> <20011115193234.A22081@lucon.org> <m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>; from hogsberg@users.sf.net on Fri, Nov 16, 2001 at 05:15:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 05:15:47PM +0100, Kristian Hogsberg wrote:
> In any case, it's the wrong fix, because the error is elsewhere:
> neither the host_info list or the node list should contain NULL
> entries.  This is just curing the symptoms.  HJ, could you provide
> some details on the crash?  Do you have the sbp2 module loaded when
> you insmod/rmmod ohci1394, and if so, does it crash without sbp2
> loaded?

No, sbp2 is not loaded.


H.J.
