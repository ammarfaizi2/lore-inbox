Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVDGI6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVDGI6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVDGI6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:58:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:34710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262364AbVDGI6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:58:53 -0400
Date: Thu, 7 Apr 2005 01:58:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1: ieee1394 process hang
Message-Id: <20050407015845.6fb3c171.akpm@osdl.org>
In-Reply-To: <4254F07B.1010500@goop.org>
References: <4254F07B.1010500@goop.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> I'm having problems with 1394 in 2.6.12-rc2-mm1.  When I connect my
>  Apple iSight camera, it is not detected; repeated
>  connections/disconnections don't help.  When I tried to rmmod all the
>  appropriate modules (rmmod video1394 raw1394 ohci1394 ieee1394), the
>  rmmod command hung.  Alt-Sysreq-t shows this:

I don't think there have been any 1394 changes recently.  This bug might be
more fallout from Pat's recent changes.

More attempts have been made to fix that stuff up.  Maybe you could try
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.12-rc2-mm1.5.gz
