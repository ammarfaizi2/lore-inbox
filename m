Return-Path: <linux-kernel-owner+w=401wt.eu-S933835AbWLJVgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbWLJVgH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933843AbWLJVgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:36:06 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:56774 "EHLO
	outmail.freedom2surf.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933835AbWLJVgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:36:04 -0500
Message-ID: <457C7D8D.7090703@f2s.com>
Date: Sun, 10 Dec 2006 21:35:09 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, kernel-discuss@handhelds.org,
       linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: Re: [Kernel-discuss] Re: parallel boot device initialisation	(kernel-space
 not userspace)
References: <4758137481lkcl@lkcl.net>	<Pine.LNX.4.64.0612081737510.1665@twin.jikos.cz>	<20061208174221.GE4666@lkcl.net> <4579EAE7.9030201@s5r6.in-berlin.de>
In-Reply-To: <4579EAE7.9030201@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Luke Kenneth Casson Leighton wrote:

> Your thought to pick one subsystem and implement multithreaded probing is
> exactly the way to go. If the subsystem is already properly using the
> driver core, part of what's needed is already in place. You "merely" have
> to look out for proper access to shared resources, and maybe synchronization
> of the final step in initialization... (Like in case of the SCSI subsystem.
> People usually want to wait for all scanning threads to finish before the
> system proceeds to mount filesystems.)

Would love to see this happen to platform devices...

