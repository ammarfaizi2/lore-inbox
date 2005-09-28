Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVI1Inf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVI1Inf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVI1Inf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:43:35 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:3256 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1030218AbVI1Ine
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:43:34 -0400
Date: Wed, 28 Sep 2005 11:43:31 +0300
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20050928084330.GC24760@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050927111038.GA22172@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050927111038.GA22172@ime.usp.br>
X-Operating-System: Linux herkules.vianova.fi 2.4.27
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:10:39AM -0300, you [Rogério Brito] wrote:
> Hi there. I'm seeing a really strange problem on my system lately and I
> am not really sure that it has anything to do with the kernels.
> 
> I would appreciate any guidance with my problems. Any help is welcome.
> 
> My desktop has a Duron 1.3GHz (but, for some reason, it runs only at
> 1.1GHz) and an Asus A7V motherboard, with chipset VIA KT133 (not the
> enhanced version KT133A).

You may be running into this problem:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.2/0574.html
http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/1727.html
http://www.cs.helsinki.fi/linux/linux-kernel/2002-01/1048.html
http://marc.theaimsgroup.com/?l=linux-kernel&m=99889965423508&w=2               

(A google search will turn up more.)

I had enourmeous trouble with Via KT133 and IDE.

Placing network card to a different PCI slot helped somewhat as did
upgrading the bios.

I NEVER got the board stable, and ended up ditching it.

It seemed to be a KT133 Northbridge DMA issue. My impression is that KT133
is utter crap period.

When browsing the viaarena.com forums, I found huge number of problem
reports about KT133 corrupting DMA transfers with sound cards, video
editing cards and IDE. It seemed to me it just can't get DMA right when it
is under heavy load. The reports were mostly windows, btw.



-- v -- 

v@iki.fi

