Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSH1NTB>; Wed, 28 Aug 2002 09:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSH1NTA>; Wed, 28 Aug 2002 09:19:00 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:61062 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S318811AbSH1NTA> convert rfc822-to-8bit;
	Wed, 28 Aug 2002 09:19:00 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Date: Wed, 28 Aug 2002 16:22:30 +0300
User-Agent: KMail/1.4.6
Cc: Doug Ledford <dledford@redhat.com>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
References: <200208271253.12192.pavenis@latnet.lv> <200208281004.07891.pavenis@latnet.lv> <1030539078.1454.8.camel@voyager>
In-Reply-To: <1030539078.1454.8.camel@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208281622.30303.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 15:51, Juergen Sawinski wrote:
> Can you drop in the old (working) source into the new tree and see if
> that works? If that works I'll try making a step by step patch series,
> to see what breaks it.

Today's tests were done in that way (I only replaced i810_audio.c,
removed i810_audio.o, run 'make modules' and 'make modules_install' and tested 
the results). As I wrote earlier it seems that Dough's patch (to 
2.4.20-pre1-ac2) broke driver

Andris

> On Wed, 2002-08-28 at 09:04, Andris Pavenis wrote:
> > Verified that sound is already broken with 2.4.20-pre1-ac2, but works
> > with i810_audio.c from 2.4.19-pre1-ac1. Commenting 2 above mentioned
> > lines out doesn't help
