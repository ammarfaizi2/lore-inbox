Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWGPXWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWGPXWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 19:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWGPXWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 19:22:07 -0400
Received: from gw.goop.org ([64.81.55.164]:24236 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751181AbWGPXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 19:22:06 -0400
Message-ID: <44BACA1C.8010609@goop.org>
Date: Sun, 16 Jul 2006 16:22:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Brandon Philips <brandon@ifup.org>
CC: George Nychis <gnychis@cmu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu> <44B66740.2040706@goop.org> <20060716222846.GA5741@plankton.ifup.org> <20060716225111.GA5661@plankton.ifup.org>
In-Reply-To: <20060716225111.GA5661@plankton.ifup.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Philips wrote:
> I just tried booting 2.6.18-rc1-mm1 again and got the following
> stacktrace which suggests a problem with the ondemand governor.   
>
> After switching to the performance govenor I was able to suspend on
> 2.6.18-rc1 and 2.6.18-rc1-mm1.
>   
Yes, I've found ondemand doesn't like being active over suspend-resume.  
There have been some bugs fixed there, but there are apparently still 
problems.  I switch to powersave over the suspend, and switch back on 
resume.

    J
