Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUJQAp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUJQAp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJQAp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:45:56 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:34376 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268900AbUJQApz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:45:55 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GypC1OJOcA8l3P7XasRz8WFrl3eX/Wp/IES9mKCMr7BqsWMyKHLFJt0lffK+AnR1c1EuLA7a5xlgLUx31oN7ivTgm+tf6oS9FjgSMBp0zulw4bvLZJ9pl33ASQ400hpj55NT8tT1RO++LoKC0oWap0B0MbfDkBur49pPy4M0vDQ
Message-ID: <81b0412b041016174530a4a00c@mail.gmail.com>
Date: Sun, 17 Oct 2004 02:45:54 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Cc: Fraz <fraz@unimail.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41650CAF.1040901@unimail.com.au>
	 <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 12:32:10 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> > Is there any way to stop this? I googled around and found it had
> > something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz
> > in the 2.4 kernel. I couldn't find much else on this. Hunting around the
> > code didn't help much, I don't know C.
> 
> Change #define HZ 1000 to #define HZ 100...

Helped an Asus S1300N. Not sure it's gone completely, but it's more
comfortable now.
 
To the original poster: look in include/asm/param.h
