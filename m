Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285054AbRLFIwh>; Thu, 6 Dec 2001 03:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285055AbRLFIwR>; Thu, 6 Dec 2001 03:52:17 -0500
Received: from kiln.isn.net ([198.167.161.1]:26898 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S285054AbRLFIwN>;
	Thu, 6 Dec 2001 03:52:13 -0500
Message-ID: <3C0F319A.329807B9@isn.net>
Date: Thu, 06 Dec 2001 04:51:38 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: small feature request
In-Reply-To: <200112060658.fB66wtp351314@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Keith Owens writes:
> > "Garst R. Reese" <reese@isn.net> wrote:
> 
> >> Would it possible to put a header on System.map indicating the kernel
> >> version?
> >> Sometimes my little brain forgets what kernel System.old is for.
> >
> > It is on my list for kbuild 2.5, once I start on the new design for
> 
> Nooooo!!!!!
> 
> Don't break stuff by adding headers. There is already a version
> in the file. It's in decimal, which sucks, but this will find it:
> 
> grep ' Version_' System.map
> 
> Adding a random 128-bit ID might be nice, as long as it's done
> in the same sort of way and is available via /proc. Something
> like this would do:  kern_128_id_UkZd1JLdOvAsALfFEL1UI
That grep does not distinguish extra versions.
Garst
