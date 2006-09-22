Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWIVRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWIVRmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWIVRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:42:14 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:65247 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964815AbWIVRmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:42:13 -0400
Date: Fri, 22 Sep 2006 19:41:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <20060922174137.GA29929@linuxtv.org>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr> <4514103D.8010303@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4514103D.8010303@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 87.162.93.17
Subject: Re: Smaller compressed kernel source tarballs?
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:33:01AM -0700, H. Peter Anvin wrote:
> Jan Engelhardt wrote:
> >>>widely used until there is an "lzip" which does the same thing.  I 
> >>>actually started the work of adding LZMA support to gzip, but then 
> >>>realized it would be better if a new encapsulation format with proper 
> >>>64-bit support everywhere was created.
> >>It doesn't handle streaming?
> >>
> >>So you can't do: tar c dirname | 7zip dirname.tar.7z ?
> >
> >man 7z [slightly changed for reasonability]:
> >
> >  -si
> >      Read data from StdIn (eg: tar -c directory | 7z a -si 
> >      directory.tar.7z)
> >
> 
> Yes, but you can't make it write to an unseekable stdout.

It seems the "lzma" program from LZMA Utils can:

http://tukaani.org/lzma/
  "Very similar command line interface than what gzip and bzip2 have."

(Debian sid has this in the "lzma" package.)


Johannes
