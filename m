Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUFXVpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUFXVpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFXVoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:44:14 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:3564 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265727AbUFXVl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:41:58 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2
Date: Thu, 24 Jun 2004 23:50:45 +0200
User-Agent: KMail/1.5
Cc: ak@muc.de, linux-kernel@vger.kernel.org
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <200406242257.03397.rjwysocki@sisk.pl>
In-Reply-To: <200406242257.03397.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406242350.45242.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 of June 2004 22:57, R. J. Wysocki wrote:
> On Thursday 24 of June 2004 10:46, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7
> >-m m2/
>
> Well, I have alarmingly many problems with this patch (my system is a dual
> Opteron - full config log attached):
>
[snip]
> 2) There is an Oops when trying to unload the sound driver (snd-intel8x0). 
> At present I'm unable to grab it. because of 1).

This Oops was also cured by reverting the:

+reduce-tlb-flushing-during-process-migration-2.patch

Yours,
rjw

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
