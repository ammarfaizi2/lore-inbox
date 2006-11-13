Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754322AbWKMKOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbWKMKOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbWKMKOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:14:00 -0500
Received: from smtp4.orange.fr ([193.252.22.27]:39772 "EHLO
	smtp-msa-out04.orange.fr") by vger.kernel.org with ESMTP
	id S1754322AbWKMKN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:13:59 -0500
X-ME-UUID: 20061113101358599.926AC1C00209@mwinf0404.orange.fr
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1163401845.5178.335.camel@gullible>
References: <1163374762.5178.285.camel@gullible>
	 <1163378981.2801.3.camel@entropy>  <1163381067.5178.301.camel@gullible>
	 <1163382425.2801.6.camel@entropy>  <1163395364.5178.327.camel@gullible>
	 <1163400313.2801.11.camel@entropy>  <1163401845.5178.335.camel@gullible>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 11:13:52 +0100
Message-Id: <1163412832.24542.3.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 23:10 -0800, Ben Collins wrote:
> Also the other case I gave where there is an alsa driver and a media
> driver for the same chipset, is by design. It can't be helped. There
> actually is a case for wanting one driver or the other in the case of
> the exact same hardware, depending on the users desire.

That one looks ugly. Probably the same driver should have a media
interface as well as an alsa interface (like alsa device are also oss
devices, no need to play evil rmmod/insmod tricks anymore).

	Xav

