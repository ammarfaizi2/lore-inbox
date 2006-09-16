Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWIPPju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWIPPju (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 11:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWIPPju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 11:39:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58798 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932410AbWIPPjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 11:39:49 -0400
Subject: Re: request for ioctl range for private devices
From: Lee Revell <rlrevell@joe-job.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jim@gibbons.com, Miguel Ojeda <maxextreme@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060916134450.50398540@localhost.localdomain>
References: <450B31BF.4050604@gibbons.com>
	 <653402b90609151726l230e9bafg5d06a36e7cd7b32c@mail.gmail.com>
	 <450B48CC.6060604@gibbons.com>
	 <20060916134450.50398540@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 11:40:49 -0400
Message-Id: <1158421249.25448.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 13:44 +0900, Stephen Hemminger wrote:
> On Fri, 15 Sep 2006 17:43:56 -0700
> Jim Gibbons <jim@gibbons.com> wrote:
> 
> > I can see that I wasn't as clear as I should have been.  Thank you for 
> > trying to figure it out anyway.
> > 
> > Please let me try again to explain.  We are using a driver interface to 
> > our kernel level code.  Our kernel level code is a loadable module.  We 
> > have no intention of modifying the kernel or of releasing our code.  We 
> > accept the implied maintenance responsibility on this private, embedded 
> > platform.
> 
> Then why should the main kernel developers do anything to help you
> with your private effort?

I think the request is valid, even for those planning to comply with the
GPL.  I'm working on an embedded device that has a similar requirement.
The code will not be submitted upstream, as the hardware is customized,
but of course we will provide driver sources to those who buy the
hardware as the GPL requires.  It would be useful to have a private
ioctl range for this.  And please don't tell me not to use an ioctl()
interface - it's the simplest way to communicate between kernel and
userspace, and since the code is not going upstream it's our choice.

Lee

