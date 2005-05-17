Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVEQLgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVEQLgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEQLYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:13 -0400
Received: from [195.23.16.24] ([195.23.16.24]:9935 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261386AbVEQKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:51:15 -0400
Message-ID: <4289CC97.9010105@grupopie.com>
Date: Tue, 17 May 2005 11:51:03 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <20050517034028.GC9699@wotan.suse.de>
In-Reply-To: <20050517034028.GC9699@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>[...]
> I would add a 
> 
> 	config HZ_10 if EMBEDDED 
> 		bool "10 Hz" 
> 
> that is useful for compute servers (although it will violate the TCP
> specification). EMBEDDED would ensure only people who know what they're
> doing set it.

I thought the lowest frequency the PIT timer would give was around 18 Hz.

Am I wrong, or are you thinking of other timing devices / different 
platforms?

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
