Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUL2RYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUL2RYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 12:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUL2RYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 12:24:00 -0500
Received: from albireo.enyo.de ([212.9.189.169]:10940 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261373AbUL2RX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 12:23:58 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Linux
References: <41D2ABA8.2080906@euroweb.net.mt>
Date: Wed, 29 Dec 2004 18:23:56 +0100
In-Reply-To: <41D2ABA8.2080906@euroweb.net.mt> (Josef E. Galea's message of
	"Wed, 29 Dec 2004 14:05:44 +0100")
Message-ID: <878y7ht3v7.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Josef E. Galea:

> Does the linux kernel allow a process to handle its own memory pages 
> instead of using the kernel's virtual memory manager?

You could play some tricks using mprotect(2), but I'm not sure if this
is enough for your application.
