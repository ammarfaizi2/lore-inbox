Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbRFAMEA>; Fri, 1 Jun 2001 08:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263463AbRFAMDt>; Fri, 1 Jun 2001 08:03:49 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:31152 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263064AbRFAMDl>; Fri, 1 Jun 2001 08:03:41 -0400
Date: Fri, 1 Jun 2001 14:03:25 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real
  this time)
In-Reply-To: <200106010858.f518w4c18391@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0106011400550.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Pete Zaitcev wrote:

> > But, each time a user cats this proc file, the user is banging the
> > hardware.  What happens when a malicious user forks off 100 processes to
> > continually cat this file?  :)
>
> Nothing good, probably. Same story as /proc/apm, which only
> hits BIOS instead (and it's debateable what is better).

Hmm, the MII related ioctl's in some net drivers (checked for 3c59x,
tulip, eepro100) are also querying the hardware. And a user is allowed to
ask for this info (but not able to modify it).

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

