Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUCUEqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 23:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUCUEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 23:46:43 -0500
Received: from mail.cyclades.com ([64.186.161.6]:27615 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263604AbUCUEql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 23:46:41 -0500
Date: Sun, 21 Mar 2004 01:35:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Bert Kammerer <mot@pronicsolutions.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.26-pre5
In-Reply-To: <001601c40ede$2d613390$0600a8c0@p17>
Message-ID: <Pine.LNX.4.44.0403210134020.4043-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2004, Bert Kammerer wrote:

> Hello Marcelo,
> 
> You're my last hope :-)
> 
> Ever since 2.4.25, when compiling it in to any RedHat 7.3 machine, the
> following appears in dmesg:
> 
> attempt to access beyond end of device
> 03:02: rw=0, want=1020128, limit=1020127
> 
> I traced this to the mount version that ships with RedHat 7.3
> (mount-2.11n). Upgrading mount to a newer version gets rid of the
> messages, but I am unsure as to whether or not the errors are really
> going away. Do you have any comments/suggestions concerning this issue?
> 
> Thanks a million!

Hi Bert,

I saw your previous email to lkml but didnt answer... 

This error is harmless: Dont worry. It will be fixed in -rc1 (which should 
be out 
Monday or so).


