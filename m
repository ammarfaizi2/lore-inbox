Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUEBW2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUEBW2C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 18:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUEBW2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 18:28:02 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:45747 "EHLO
	vsmtp2alice.tin.it") by vger.kernel.org with ESMTP id S263338AbUEBW17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 18:27:59 -0400
Message-ID: <40957585.5060105@copeca.dsnet.it>
Date: Mon, 03 May 2004 00:26:13 +0200
From: Giuliano Colla <copeca@copeca.dsnet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031016
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it> <409276D6.9070500@gmx.net> <4092A88D.70007@copeca.dsnet.it> <Pine.GSO.4.58.0405021030410.7925@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0405021030410.7925@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven ha scritto:

>On Fri, 30 Apr 2004, Giuliano Colla wrote:
>  
>
>>It may make sense not to have anything left in the GPL directory in a
>>binary only .rpm package, because once linked GPL parts cannot be told
>>apart from non-GPL ones.
>>    
>>
>
>When speaking about loadable kernel modules: yes they can! That's what
>modinfo(8) is for!
>
>Oh wait, someone played tricks with a \0 character...
>
>Gr{oetje,eeting}s,
>
>  
>
What I mean is that in a binary rpm you have binaries which link 
together GPL and non GPL code. There's not such a thing as a GPL 
binaries to put in the GPL directory. This holds true whether they play 
tricks or not. If you want to see the GPL'd code you must download the
source package.
You may blame them for playing tricks with \0 character, but you can't 
blame them for an empty GPL directory in the binary package, when you 
find it properly populated in the source package.

Groetje,
-----
Giuliano Colla

Whenever people agree with me, I always feel I must be wrong (O. Wilde)


