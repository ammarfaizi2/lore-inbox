Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268909AbRHHTtg>; Wed, 8 Aug 2001 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHHTtR>; Wed, 8 Aug 2001 15:49:17 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:52742 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S268909AbRHHTtG>; Wed, 8 Aug 2001 15:49:06 -0400
Date: Wed, 8 Aug 2001 15:49:16 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Mike Jadon <mikej@umem.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI NVRAM Memory Card
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
Message-ID: <Pine.LNX.4.33.0108081541430.23903-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Mike Jadon wrote:

> My company has released a PCI NVRAM memory card but we haven't developed a
> Linux driver for it yet.  We want the driver to be open to developers to
> build upon.  Is there a specific path we should follow with this being our
> goal?  In researching Linux driver development I have come across "GPL" or
> "LGPL".  Where do you recommend we go to find out more about this
> development process?
>
> Thanks and my apologies for using a technical forum for this question, but
> wanted to go to the right source.
>
>
> Mike

Real simple.

Anything that goes into the kernel should be GPLed, because the kernel is
GPLed and one of the clauses states that anything linked with or derived from
a GPLed work must also be GPLed.

User-mode libraries should be LGPLed, because software linked to LGPLed
software does not have to be GPLed or LGPLed (i.e., commercial packages), but
derivatives must be LGPLed.

There are also other licenses that you can consider, although GPL and LGPL are
usually considered the most fair (except by Microsoft, of course). You can get
more info at http://www.gnu.org/philosophy/license-list.html.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>



