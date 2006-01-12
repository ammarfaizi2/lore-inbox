Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWALAJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWALAJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWALAJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:09:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbWALAJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:09:00 -0500
Date: Wed, 11 Jan 2006 16:08:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] new tty buffering access fix
Message-Id: <20060111160823.6bc95ab8.akpm@osdl.org>
In-Reply-To: <1137023508.3113.10.camel@x2.pipehead.org>
References: <1137023508.3113.10.camel@x2.pipehead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
>  Fix typos in new tty buffering that incorrectly
>  access and update buffers in pending queue.

Curious.  How did this manage to sneak through without anyone noticing? 
Does tty_buffer_request_room() mostly work, or do only rarely-used drivers
use it, or what?
