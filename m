Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUAUVeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUAUVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:34:50 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:17058 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262328AbUAUVer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:34:47 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: logging all input and output on a tty
References: <87ad4h5juk.fsf@online.no> <1074708271.4724.5.camel@gax.mynet>
From: Esben Stien <executiv@online.no>
Date: 21 Jan 2004 22:34:05 +0100
In-Reply-To: <1074708271.4724.5.camel@gax.mynet>
Message-ID: <87u12p3s1e.fsf@online.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludootje <ludootje@linux.be> writes:

> You can just cat the device, like cat /dev/tty<number>. So you can also
> use normal redirectors (> , >> etc) or use a pager.

If I do cat /dev/tty1 on /dev/tty2, I see what I write to /dev/tty1 on /dev/tty2, but I don't see what I write to /dev/tty1 while working in /dev/tty1 (all the input is being printed on /dev/tty2) . And besides, I only see the input I type, not the output of f.ex a command (on /dev/tty2). I want to monitor users and log everything that is done on a specific tty when they log in. 

-- 
b0ef

