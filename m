Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWDHOSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWDHOSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDHOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:18:22 -0400
Received: from mail.suse.de ([195.135.220.2]:61917 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751390AbWDHOSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:18:22 -0400
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Black box flight recorder for Linux
Date: Sat, 8 Apr 2006 09:17:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it> <4437C335.30107@shaw.ca>
In-Reply-To: <4437C335.30107@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604080917.39562.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2006 16:05, Robert Hancock wrote:
> Andi Kleen wrote:
> > James Courtier-Dutton <James@superbug.co.uk> writes:
> >> Now, the question I have is, if I write values to RAM, do any of those
> >> values survive a reset?
> >
> > They don't generally.
> >
> > Some people used to write the oopses into video memory, but that
> > is not portable.
>
> I wouldn't think most BIOSes these days would bother to clear system RAM
> on a reboot. Certainly Microsoft was encouraging vendors not to do this
> because it slowed down system boot time.to

Reset button is like a cold boot and it generally ends up with cleared 
RAM.

-Andi
