Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319009AbSHUTaw>; Wed, 21 Aug 2002 15:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319073AbSHUTav>; Wed, 21 Aug 2002 15:30:51 -0400
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:30943 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S319009AbSHUTat>; Wed, 21 Aug 2002 15:30:49 -0400
Date: Wed, 21 Aug 2002 13:34:53 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Hugh Dickins <hugh@veritas.com>
cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <Pine.LNX.4.44.0208211826180.10811-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208211242440.10117-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Hugh Dickins wrote:

> You do need CONFIG_SMP and a processor capable of HyperThreading,
> i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> just appropriate to that processor in other ways.

I was under the impression that the only CPU capable of hyperthreading was
the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
have the ht feature.

Also, looking at setup.c it's hard to determine if CONFIG_SMP is
actually required, but it doesn't look like it...

Regards
James Bourne

> 
> Hugh
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


