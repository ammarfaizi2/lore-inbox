Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932831AbWKTIej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWKTIej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933042AbWKTIej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:34:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49608 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932831AbWKTIei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:34:38 -0500
Subject: Re: Re[2]: Where did find_bus() go in 2.6.18?
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <664994303.20061120021314@gmail.com>
References: <1154868495.20061120003437@gmail.com>
	 <4560ECAF.1030901@gmail.com>  <664994303.20061120021314@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 20 Nov 2006 09:34:35 +0100
Message-Id: <1164011675.31358.566.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 02:13 +0200, Paul Sokolovsky wrote:
> Hello Jiri,
> 
> Monday, November 20, 2006, 1:45:51 AM, you wrote:
> 
> > Paul Sokolovsky wrote:
> >>   But alas, the commit message is not as good as some others are, and
> >> doesn't mention what should be used instead. So, if find_bus() is
> >> "unused", what should be used instead?
> 
> > You should probably mention what for?
> 
>   Indeed, I'm sorry! Looking at find_bus()'s docstring:
> 
> /**
>  *      find_bus - locate bus by name.
>  *      @name:  name of bus.
> 
>  So well, I'd like to know exactly that - what function should be
> used instead of find_bus() to locate bus by name.

I think the question more was "what do you need to look up a bus by name
for in the kernel"? Like.. what are you trying to achieve? What module
is this for? (does it have a homepage where people can download the
source etc so that they can give you a more informed answer)....


> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

