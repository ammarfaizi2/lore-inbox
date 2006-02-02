Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBBUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBBUwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBBUwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:52:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18342 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932242AbWBBUwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:52:01 -0500
Date: Thu, 2 Feb 2006 21:51:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Olivier Galibert <galibert@pobox.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202205148.GE2264@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net> <20060202154319.GA96923@dspnet.fr.eu.org> <20060202202527.GC2264@elf.ucw.cz> <20060202203155.GE11831@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060202203155.GE11831@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 15:31:55, Dave Jones wrote:
> On Thu, Feb 02, 2006 at 09:25:27PM +0100, Pavel Machek wrote:
>  > On Čt 02-02-06 16:43:19, Olivier Galibert wrote:
>  > > On Thu, Feb 02, 2006 at 10:28:15PM +1000, Nigel Cunningham wrote:
>  > > > Shouldn't the question be "Why are we making this more complicated by moving 
>  > > > it to userspace?"
>  > > 
>  > > Indeed.  It seems that turning the kernel into Hurd is the latest
>  > > fad.
>  > 
>  > Heh, try reading suspend2.
> 
> Can we leave the playground level insults off of linux-kernel please,
> and keep the discussion at a technical level ?
> 
> Such remarks aren't furthering the cause of either implementation.

Well, Olivier said I'm turning kernel into Hurd. So he instead
advocates merging 10 000 lines of code (+7500, contains new
compression algorithm and new plugin architecture). I'd like to add
interface to userland (+300) and remove swap writing (long term,
-1000).

Olivier clearly did not see the patches; is asking him to learn what
he is talking about *that* much to ask?
								Pavel
-- 
Thanks, Sharp!
