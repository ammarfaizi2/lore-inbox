Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJNEcD>; Sun, 14 Oct 2001 00:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274244AbRJNEbx>; Sun, 14 Oct 2001 00:31:53 -0400
Received: from ppp-RAS1-2-181.dialup.eol.ca ([64.56.225.181]:10763 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S274194AbRJNEbn>; Sun, 14 Oct 2001 00:31:43 -0400
Date: Sun, 14 Oct 2001 00:31:36 -0400
From: William Park <opengeometry@yahoo.ca>
To: pd <pdickson@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI modem doesn't work after 2.4.2->2.4.10 upgrade
Message-ID: <20011014003136.A2031@node0.opengeometry.ca>
Mail-Followup-To: pd <pdickson@att.net>, linux-kernel@vger.kernel.org
In-Reply-To: <01101319043002.01369@gabrielle.pdickson.newboston.nh.us> <20011013190658.A32535@hapablap.dyn.dhs.org> <p04320401b7eeb405a4a8@[12.79.180.246]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p04320401b7eeb405a4a8@[12.79.180.246]>; from pdickson@att.net on Sat, Oct 13, 2001 at 11:21:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 11:21:58PM -0400, pd wrote:
> >Unlike 2.4.2, 2.4.10 can automatically detect and configure PCI modems.
> >That's why its already in use to setserial.  The kernel has already
> >found your modem, and assigned it ttyS4 (0-3 are reserved for the
> >standard COM1-4).  Theoretically, then, all you have to do is relink
> >/dev/modem to /dev/ttyS4, and you should be set.
> 
> That is exactly what it turned out to be.  Tnx.  Works fine now.

Hi pd,

Which PCI modem do you have?

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8 CPU cluster, Linux (Slackware), Python, LaTeX, Vim, Mutt, Tin
