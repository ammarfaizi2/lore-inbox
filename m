Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWF0Vr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWF0Vr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWF0Vrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:47:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63154 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161330AbWF0Vry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:47:54 -0400
Date: Tue, 27 Jun 2006 23:47:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Brad Campbell <brad@wasp.net.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm
Message-ID: <20060627214743.GM29199@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627190323.GA28863@elf.ucw.cz> <20060627191903.GJ7914@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627191903.GJ7914@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 15:19:03, Dave Jones wrote:
> On Tue, Jun 27, 2006 at 09:03:24PM +0200, Pavel Machek wrote:
> 
>  > uswsusp already uses normal I/O ... and that is asynchronous.
> 
> Errm, no. it isn't.

Okay...

It is asynchronous on the write part. On the read part, it is not, but
that should be okay... readahead should save us.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
