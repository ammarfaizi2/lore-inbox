Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHKQK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHKQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWHKQK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:10:27 -0400
Received: from mail.suse.de ([195.135.220.2]:48073 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932201AbWHKQKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:10:23 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev structures as __cpuinitdata
Date: Fri, 11 Aug 2006 18:07:47 +0200
User-Agent: KMail/1.9.3
Cc: Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200608111126_MC3-1-C7CA-65CE@compuserve.com>
In-Reply-To: <200608111126_MC3-1-C7CA-65CE@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111807.47556.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But none of these CPUs supports hotplug and only one (AMD) does SMP.
> So this is just wasting space in the kernel at runtime.
> 
> If anything I would only do this for AMD.
> 
> Same for the other patch that does more of this kind of change.
> 
> (IIRC I tried to do this a while ago and was told not to.)

But wouldn't the reference check during build always warn if that 
wasn't fixed?

-Andi
