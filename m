Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVCaORW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVCaORW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVCaORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:17:22 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:17815 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261460AbVCaORA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:17:00 -0500
Date: Thu, 31 Mar 2005 16:17:26 +0200
From: DervishD <lkml@dervishd.net>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
Message-ID: <20050331141726.GA654@DervishD>
Mail-Followup-To: Mariusz Mazur <mmazur@kernel.pl>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050330162114.GA1028@DervishD> <200503302240.08200.mmazur@kernel.pl> <20050331074526.GA8614@DervishD> <200503311426.48435.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503311426.48435.mmazur@kernel.pl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mariusz :)

 * Mariusz Mazur <mmazur@kernel.pl> dixit:
> >     I don't know which set of headers will work, and in fact I don't
> > know if I must follow 'Linux From Scratch' advice and use raw kernel
> > headers for building glibc and LLH headers for any other thing. I
> > think I probably will use the LLH headers (including scsi) for
> > everything since glibc passes the 'make check' doing that... If I
> > screw my system badly, I have lotsa backups at hand.
> Like I've said, you're unable to break your system this way.

    I think so... 

> And I don't see any point in LFS suggesting using raw kernel
> headers to compile glibc

    I don't know their reasons because I haven't read any rationale
(if any exists at all). Anyway, I've used LLH (including the scsi
part) for building my new glibc and 'make check' passes. In fact, I'm
answering this email from the system I've upgraded, so glibc seems to
work ok ;)

> (no you can't* screw up your system by using llh unless I
> *specifically switch ioctls so apps remove files instead of opening
> them; I just can't see any possibility to do it by accident).
 
    That's what I thought. Apps must, first, use glibc headers, not
kernel ones, and that cannot be broken by using llh, and in fact I
rely on llh because mistakes in the kernel headers will probably be
noticed very, very fast.
 
> And I'll add an entry to the llh FAQ to clear this matter up.

    Thank you :) BTW, you've done a great work with llh. I really
like it and that's the reason I chose llh and not raw kernel headers
in the first place. Keep on doing such a great job :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
