Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTFYJNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFYJNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:13:40 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:12711 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264279AbTFYJNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:13:39 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Success stories, disappearing Oopses and ps/2 keyboard
Date: Wed, 25 Jun 2003 11:27:37 +0200
User-Agent: KMail/1.5.1
References: <20030624164026.GA2934@sexmachine.doom> <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com> <20030625081313.GA1747@sexmachine.doom>
In-Reply-To: <20030625081313.GA1747@sexmachine.doom>
Cc: lkml@kcore.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306251127.37944.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 10:13, Konstantin Kletschke wrote:
> No, that would be no Problem. Often, if I browse in mutt and press Arrow
> Keys, it is autorepeated suddenly but I only pressed the Key shortly!
> The Kernel does not realize it is released since ages. Pressing again
> the kernel stops repeating. That happens with all keys and when with
> arrow or PageUp/Down keys in slrn it drives me mad!

I have seen this problem ever since I started using 2.5 on my laptop. I can 
easily recreate it by pressing two keys at the same time, it seems that then 
something gets screwed up and he repeats one of the two keys 20-30 times when 
it stops.

I'll test with that clock=pit option later, when I have the chance to reboot.

Jan
-- 
Q:  How did you get into artificial intelligence?
A:  Seemed logical -- I didn't have any real intelligence.

