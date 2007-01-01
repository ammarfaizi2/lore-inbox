Return-Path: <linux-kernel-owner+w=401wt.eu-S1755209AbXAAOUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbXAAOUp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbXAAOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:20:45 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:58581 "EHLO outpost.ds9a.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209AbXAAOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:20:44 -0500
Date: Mon, 1 Jan 2007 15:20:42 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Using _syscall3 to manipulate files in a driver
Message-ID: <20070101142042.GA19828@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 12:13:52PM -0500, Jon Smirl wrote:
> What is the simplest way to get open/close/read/write working under
> 2.6.20-rc2? I know this is horrible and shouldn't be done, I just want
> to get the driver working long enough to see if it is worth saving.

I'm no expert, but try looking at the firmware loading code in the kernel,
it reads files, so it should contain the code you need. It may even do
exactly what you want, perhaps.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
