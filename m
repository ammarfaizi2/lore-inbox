Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJBMzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJBMzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 08:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJBMzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 08:55:22 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:30951 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261232AbUJBMzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 08:55:18 -0400
Subject: Re: [PATCH] khpsbpkt exists on suspend
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Olaf Hering <olh@suse.de>
Cc: Ben Collins <bcollins@debian.org>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041002083123.GB24322@suse.de>
References: <20040923221018.GA15788@suse.de>
	 <20041002083123.GB24322@suse.de>
Content-Type: text/plain
Message-Id: <1096721851.18552.6.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 02 Oct 2004 22:57:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-10-02 at 18:31, Olaf Hering wrote:
> sw-suspend does not work with our kernel.
> khpsbpkt will die because down_interruptible returns -EINTR on suspend.
> As a result, hpsb packet delivery will not work anymore after resume.

I've applied the fix to the suspend2 tree fwiw.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

