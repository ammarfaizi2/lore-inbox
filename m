Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbTIKR1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIKRXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:23:48 -0400
Received: from port-212-202-40-6.reverse.qsc.de ([212.202.40.6]:47489 "EHLO
	schillernet.dyndns.org") by vger.kernel.org with ESMTP
	id S261411AbTIKRTl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:19:41 -0400
Date: Thu, 11 Sep 2003 17:19:39 +0000 (UTC)
Message-Id: <20030911.171939.291444707.rene.rebe@gmx.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during
 PM-wake
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1063262157.2023.19.camel@gaston>
References: <1063221565.678.2.camel@gaston>
	<20030910.222620.730549923.rene.rebe@gmx.net>
	<1063262157.2023.19.camel@gaston>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Thu, 11 Sep 2003 08:35:57 +0200,
    Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > so hm?!? - is the wakeup order of the devices incorrect (i2c needs to
> > be before damsound_pmac ...)?
> 
> The i2c bus isn't suspended during sleep... I don't know for sure
> what's up, I'll investigate.

I added a schedule_timeout without success ... - should I check if
self is correct? Or any other idea?

Sincerely yours,
  René

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.net/people/rene
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

