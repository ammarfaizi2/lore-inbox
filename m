Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTJZQNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTJZQNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:13:11 -0500
Received: from 217-124-33-154.dialup.nuria.telefonica-data.net ([217.124.33.154]:55169
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263260AbTJZQNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:13:09 -0500
Date: Sun, 26 Oct 2003 17:13:06 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
Message-ID: <20031026161306.GA16723@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F9BC429.6060608@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9BC429.6060608@planet.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 26 October 2003, at 13:55:05 +0100,
Stef van der Made wrote:

> The system configuration is as following.
> 
Try first to isolate the kind of disk activity happening: is it writes,
reads, a mix of them ?. Start some monitoring program like "vmstat",
"sar" or even "xosview" or "gkrellm" to see the kind of disk access
pattern happens when your box does things of its own :-)

Also, to put swap out of the equation you could disable it and see if
the problem happens again, etc.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test8-mm1)
