Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRCNB5o>; Tue, 13 Mar 2001 20:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCNB5f>; Tue, 13 Mar 2001 20:57:35 -0500
Received: from CPE-61-9-150-8.vic.bigpond.net.au ([61.9.150.8]:19346 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S131152AbRCNB5Y>; Tue, 13 Mar 2001 20:57:24 -0500
Date: Wed, 14 Mar 2001 12:59:31 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: Re: system call for process information?
Message-ID: <20010314125931.H918@higherplane.net>
In-Reply-To: <200103132105.f2DL5D8411265@saturn.cs.uml.edu> <Pine.LNX.4.21.0103131951590.2056-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0103131951590.2056-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Tue, Mar 13, 2001 at 07:52:41PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 07:52:41PM -0300, Rik van Riel wrote:
> On Tue, 13 Mar 2001, Albert D. Cahalan wrote:
> 
> > Bloat removal: being able to run without /proc mounted.
> >
> > We don't have "kernel speed". We have kernel-mode screwing around
> > with text formatting.
> 
> Sounds like you might want to maintain an external patch
> for the embedded folks...

or perhaps a patch to remove the non-procfs stuff from proc - leaving
just /proc/[0-9]+ and /proc/self...

that way top/ps/ still mostly work without patches and you dont have all
the other stuff that you don't need (perhaps make a separate kernfs?).

i *am* aware of the previous flamewars over this :-) but it does appear
to me a more generally useful compromise in the anti-bloat case.

j. (who likes proc as it is now)
