Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTDIVAW (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTDIVAW (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:00:22 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:64780 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S263823AbTDIVAO (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 17:00:14 -0400
Date: Wed, 9 Apr 2003 23:11:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: hpa@zytor.com, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200304091836.h39IaWE29913.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304092256440.5042-100000@serv>
References: <UTC200304091836.h39IaWE29913.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Apr 2003 Andries.Brouwer@cwi.nl wrote:

> Your questions are about the meaning of this number,
> that is, about the third part. What I am doing is only
> removing certain restrictions on the size of the number.

If your patches would just removes these restriction, I wouldn't mind at 
all, but your patches do more than that. Why?

> Your letters carry the tone of "it is forbidden to work on the
> old scheme before you have shown how to solve all device naming
> problems". But I am not going to.
> 
> You have opinions and questions about future schemes.
> And so do I. But since time is limited I wrote you
> already a handful of times: "Later".
> 
> This number stuff is simple and straightforward, we know precisely
> what has to be done, but of course it needs to be done.

I don't want to forbid you anything, I want that you explain what you do, 
as your patches do more than simply enlarging dev_t. You still avoid any 
clear answer about this.

> Naming on the other hand is intricate, lots of complications.
> Device naming - but what is a device? Already that is complicated.
> These are good discussions, and maybe sysfs will provide the answer
> in certain cases, but these discussions are independent of dev_t.

They are not independent. You want to have a larger dev_t so it can be 
used for 2.6, but this also requires an answer to the question "How will 
it be used during 2.6?".

bye, Roman

