Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLNHvs>; Thu, 14 Dec 2000 02:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbQLNHvj>; Thu, 14 Dec 2000 02:51:39 -0500
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:7173 "HELO
	gateway.intern.kubla.de") by vger.kernel.org with SMTP
	id <S129732AbQLNHvY>; Thu, 14 Dec 2000 02:51:24 -0500
Date: Thu, 14 Dec 2000 08:20:50 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001214082050.A21451@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Petr Konecny <pekon@informatics.muni.cz>,
	jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org
In-Reply-To: <qww1yvbivm0.fsf@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <qww1yvbivm0.fsf@decibel.fi.muni.cz>; from pekon@informatics.muni.cz on Thu, Dec 14, 2000 at 03:29:11AM +0100
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:29:11AM +0100, Petr Konecny wrote:
> >
> > Look at linux/Dokumentation/fb/modedb.txt.
> >
> It's not in my tree (2.2.18), the only documentation I could find was
> the source code. Anyway, it seems that atyfb gets a precendence over
> vesafb and screws up the LCD. Right now I use the following kernel params:
> video=atyfb:off video=vesa:mtrr vga=795

My fault: i was looking at a 2.4.0-test* tree... But i think that information
holds true for 2.2.* as well.

Dominik Kubla
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
