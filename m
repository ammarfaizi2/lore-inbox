Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbTCCAqM>; Sun, 2 Mar 2003 19:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268218AbTCCAqM>; Sun, 2 Mar 2003 19:46:12 -0500
Received: from 211.228.252.64.snet.net ([64.252.228.211]:27265 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S268175AbTCCAqJ>;
	Sun, 2 Mar 2003 19:46:09 -0500
Message-Id: <200303030100.h23102L07592@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever done multicast AF_UNIX sockets? 
In-Reply-To: Your message of "03 Mar 2003 01:23:25 GMT."
             <1046654604.4431.0.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Mar 2003 20:00:02 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> On Mon, 2003-03-03 at 00:05, Michael Richardson wrote:
> >   First, multicast doesn't really work on loopback. I don't recall
> > why... One symptom of this is that one can't use the multicast transport
> > for User-Mode-Linux when not "online" (i.e. on the train).
>
> You have to specify you want your multicast packet looped back. By
> default multicasts dont loop 

Well, that problem is actually that lo and dummy interfaces don't support
multicast.  You need something like an eth device for multicast, even if you're
nowhere near a LAN.

				Jeff

