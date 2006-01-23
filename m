Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWAWBJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWAWBJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWAWBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:09:50 -0500
Received: from elvis.mu.org ([192.203.228.196]:63734 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S932417AbWAWBJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:09:50 -0500
Message-ID: <43D42CCE.9010709@FreeBSD.org>
Date: Sun, 22 Jan 2006 17:09:34 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: Diego Calleja <diegocg@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net>	<20060122093144.GA7127@thunk.org> <20060122205039.e8842bae.diegocg@gmail.com> <43D42AA2.6040106@comcast.net>
In-Reply-To: <43D42AA2.6040106@comcast.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> Yeah, the huge TB fsck thing became a problem.  I wonder still if it'd
> be useful for small vfat file systems (floppies, usb drives); nobody has
> led me to believe it's definitely feasible to not corrupt meta-data in
> this way.

Please note that you don't *HAVE* to run fsck at every reboot. All 
background fsck does is reclaim unused blocks.

-- Suleiman
