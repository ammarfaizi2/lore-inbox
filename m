Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVACVqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVACVqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVACVqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:46:42 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:44360 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261418AbVACVqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:46:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=oh2m1qw+tc7EOOC2GccgLo/fm9VRUDwm6zMvKMzE7/IUj+69c918s1BDYwZrVxdEIfqCifAw6f/RC/jXfi2GujILM1RakKv/gSb/8boLs9njjPN0Cju6sr4fXWVp0NFYz3kqQcmkXYSq3pvUxTyf8i7pWyMzLJVfiFgxP/AEYzg=
Message-ID: <5a2cf1f6050103134611114dbd@mail.gmail.com>
Date: Mon, 3 Jan 2005 22:46:40 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 50% CPU user usage but top doesn't list any CPU unfriendly task
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on a fairly old box used as a desktop (PII 300 Mhz with 196M RAM), I
observe the following strange behavior which I believe comes from the
kernel.

There's a VoIP known 'P2P' closed source application running, an IP
tables based firewall and a remote ssh session initiated. When using
top, sorting by CPU usage, no program is using more than a couple of
percent of CPU. On the other side, the total CPU user time is at
around 40%, with a 1.5 load average. Memory looks OK. The machine is
responsive as usual.

So I wonder why the cpu user time is at 40% without any particular
program showing as using CPU in the top listing. 'Problem' was
reproducible with 2.4.x and now with 2.6.8.1.

So it this a real problem or is there something that I don't
understand in particular? Thanks for the insight.

Jerome
