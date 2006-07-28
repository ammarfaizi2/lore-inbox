Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWG1WpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWG1WpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWG1WpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:45:05 -0400
Received: from mail.gmx.de ([213.165.64.21]:30125 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161346AbWG1WpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:45:04 -0400
X-Authenticated: #271361
Date: Sat, 29 Jul 2006 00:44:59 +0200
From: Edgar Toernig <froese@gmx.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /dev/itimer
Message-Id: <20060729004459.11a85a27.froese@gmx.de>
In-Reply-To: <1154126015.2451.13.camel@entropy>
References: <20060728235951.7de534eb.froese@gmx.de>
	<1154126015.2451.13.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
>
> Solaris lets you specify SIGEV_PORT in your struct sigevent which then
> queues timer completions (or anything else that takes a struct sigevent,
> like POSIX AIO) to a port and then all types of queued events (including
> fd polling and user generated events) can be waited on and fetched with
> a single function call.

There must be a reason that I haven't seen that used in the wild yet ...

Ciao, ET.
