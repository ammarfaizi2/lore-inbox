Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUJPLuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUJPLuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUJPLuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:50:18 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:52969 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S268702AbUJPLuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:50:14 -0400
Date: Sat, 16 Oct 2004 13:50:14 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org, albert@users.sf.net
Subject: Re: [PATCH, RFC] bring /proc/pid/stat and /proc/pid/task/tid/stat in line with getrusage
Message-ID: <20041016115014.GA12141@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, albert@users.sf.net
References: <20041016102948.GA8958@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016102948.GA8958@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 12:29:48PM +0200, bert hubert wrote:

> I'm happy to hear comments, but I hope this patch will be considered as it
> solves real world problems, even though it might confuse some theoretically
> task-aware procps tools (which I did not find).

To clarify - "ps -eLf" does traverse /proc/pid/task/tid/ , so yes, there are
tools which are task-aware. But in this case, I meant that it does not
matter as the output of /proc/pid/task/tid/stat is unchanged by my patch.

I more exactly meant that to my knowledge, no procps tools add up all the
tasks in /ptoc/pid/task/tid and present them as one process.

Sorry for the confusion.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
