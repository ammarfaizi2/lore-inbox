Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275274AbTHMQkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275276AbTHMQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:40:09 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37583 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275274AbTHMQkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:40:05 -0400
Date: Wed, 13 Aug 2003 17:39:27 +0100
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813163927.GE2184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel> <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel> <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain> <20030813131457.GD32290@wotan.suse.de> <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk> <20030813142055.GC9179@wotan.suse.de> <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 04:20:11PM +0100, Alan Cox wrote:
 > K6-II/III does. I don't know about original K6. but I believe it
 > doesn't. The original 3Dnow was a joint Cyrix/AMD thing and it lacks 
 > several instructions later added (including prefetch). The later Cyrix
 > also has a couple of the additional ones but not prefetch.

Which Cyrixen are you talking about ?
C3's up to and including Ezra-T should DTRT when it comes to
3dnow prefetch instruction, and pre-VIA Cyrixen didn't have 3dnow
at all iirc.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
