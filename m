Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTKCFQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 00:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTKCFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 00:16:10 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:52231 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261893AbTKCFQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 00:16:08 -0500
Date: Mon, 3 Nov 2003 06:16:03 +0100
From: Willy Tarreau <willy@w.ods.org>
To: CN <cnliou9@fastmail.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: i8253 counting too high! resetting..
Message-ID: <20031103051603.GE530@alpha.home.local>
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com> <20031030171235.GA59683@teraz.cwru.edu> <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com> <200310310040.19519.gene.heskett@verizon.net> <20031031063636.GA61826@teraz.cwru.edu> <20031103044155.8D0067DF67@server2.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103044155.8D0067DF67@server2.messagingengine.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 02, 2003 at 08:41:55PM -0800, CN wrote:
> As reported in my first message, the box running kernel 2.4.22 and
> Fjuitsu HD generated i8253 message while the other box running 2.4.20 and
> Maxtor did not. During the past 3 days I wiped out everything from the HD
> and reinstalled Debian woody on to the "normal" box (with Maxtor) and
> rebuilt the kernel to 2.4.22. This used-to-be normal box started to
> generate the i8253 message since then.

There's a simple reason for what you see : this message was introduced in
2.4.21 to detect buggy hardware. Before 2.4.21, you only had the luck to
see time go backwards without any apparent reason. There was a very long
thread about gettimeofday() jumping backwards a few months ago in which
you may find detailed informations about this problem.

Regards,
Willy

