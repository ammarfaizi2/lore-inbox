Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRKDTCn>; Sun, 4 Nov 2001 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRKDTCd>; Sun, 4 Nov 2001 14:02:33 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46351 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273261AbRKDTCa>;
	Sun, 4 Nov 2001 14:02:30 -0500
Date: Sun, 4 Nov 2001 20:02:26 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance
Message-Id: <20011104200226.3fcd974c.skraw@ithnet.com>
In-Reply-To: <200111041810.fA4IAQY68511@aslan.scsiguy.com>
In-Reply-To: <20011104151726.06193c01.skraw@ithnet.com>
	<200111041810.fA4IAQY68511@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Nov 2001 11:10:26 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >Nope.
> >I know the stuff :-) I already took tcq down to 8 (as in old driver) back at
> >the times I compared old an new driver.
> 
> Then you will have to find some other reason for the difference in
> performance.  Internal queuing is not a factor with any reasonable
> modern drive when the depth is set at 8.

Hm, obviously we could start right from the beginning and ask people with aic
controllers and symbios controllers for some comparison figures. Hopefully some
people are interested.

Here we go:
Hello out there :-)
we need your help. If you own a scsi-controller from adaptec or one with
ncr/symbios chipset can you please do the following:
reboot your box. Start xcdroast and read in a data cd. Tell us: brand of your
cdrom, how much RAM you have, processor type, throughput as measured by
xcdroast. Nice would be if you try several times.
We are not really interested in the hard figures, but want to extract some
"global" tendency.

Thank you for your cooperation, 

Stephan

PS: my values are (I obviously have both controllers):

Adaptec:

Drive TEAC-CD-532S (30x), 1 GB RAM, 2 x PIII 1GHz
test 1: 2998,9 kB/s
test 2: 2968,4 kB/s
test 3: 3168,2 kB/s

Tekram (symbios)

Drive TEAC-CD-532S (30x), 1 GB RAM, 2 X PIII 1GHz
test 1: 3619,3 kB/s
test 2: 3611,1 kB/s
test 3: 3620,2 kB/s

