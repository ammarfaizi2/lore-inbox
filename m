Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSADAcL>; Thu, 3 Jan 2002 19:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288423AbSADAcB>; Thu, 3 Jan 2002 19:32:01 -0500
Received: from relay1.pair.com ([209.68.1.20]:34322 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288422AbSADAb5>;
	Thu, 3 Jan 2002 19:31:57 -0500
X-pair-Authenticated: 24.126.75.67
Message-ID: <3C34F8C6.6B5C4C67@kegel.com>
Date: Thu, 03 Jan 2002 16:35:18 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.gmd.de>
CC: anderson@metrolink.com, hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, Rusty Russell <rusty@rustcorp.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
In-Reply-To: <200201032355.g03Ntx911860@burner.fokus.gmd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> ...
> The way /proc works has been introduced by Plan 9 in the first half of the 80s.
> What Linux added as an abuse of the /proc filesytem in principle is a Plan 9
> idea too. It makes sense to  have something similar, but please please _not_
> inside the /proc tree.
> 
> Sun is planning to have /sys with similar backgound in a future version of
> Solaris so it wouls make sense to talk to the Solaris kernel kackers to have a
> common way to go for the new /sys tree.

FWIW, Rusty Russell is working on a replacement for /proc/sys in Linux;
see http://lwn.net/2002/0103/a/proc.php3
I wonder if he's talked to the Solaris people about their /sys plans.

> If you like to look for other ideas on how to retrieve the needed information
> it makes sense to look at Solaris too. The reason is that Solaris uses "prtconf"
> which is close to the device tree from the IEEE standard Boot loader.
> 
> prtconf -p is giving exactly the IEEE device tree
> 
> prtconf -p -v gives more verbose information.
> 
> If you don't use -p you will see the kernel view of the device tree.
> 
> On MacOS X which also uses the IEEE Boot architecture the same beast
> will be shown via a 'ioreg -l'

That's interesting stuff, thanks.
- Dan
