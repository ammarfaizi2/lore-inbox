Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDATGl>; Sun, 1 Apr 2001 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDATGg>; Sun, 1 Apr 2001 15:06:36 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:741 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S132534AbRDATFe>; Sun, 1 Apr 2001 15:05:34 -0400
Date: Sun, 1 Apr 2001 21:00:18 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
cc: <linux-scsi@vger.kernel.org>
Subject: Re: scsi bus numbering
In-Reply-To: <3AC752DA.20F5A54@torque.net>
Message-ID: <Pine.LNX.4.30.0104012054180.779-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Douglas Gilbert wrote:

[...]

> >>>>>>>>>  scsihosts  <<<<<<<<<<<<<
>
> As a boot time option try:
>   scsihosts=aic7xxx:ncr53c8xxx
> or if you are using lilo, in /etc/lilo.conf add:
>   append="scsihosts=aic7xxx:ncr53c8xxx"

that does indeed change the bus numbering. Unfortunately, even
with this option, the first disk on the ncr controller becomes
"/dev/sda" ...

regards,
               Peter Daum

