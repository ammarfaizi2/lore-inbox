Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032382AbWLGQ2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032382AbWLGQ2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032385AbWLGQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:28:18 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:41878 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032382AbWLGQ2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:28:17 -0500
Date: Thu, 7 Dec 2006 08:28:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: The drivers Kconfig structure:  oddities and exceptions
Message-Id: <20061207082824.40c46170.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612070405510.15805@localhost.localdomain>
References: <Pine.LNX.4.64.0612070405510.15805@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 04:36:25 -0500 (EST) Robert P. J. Day wrote:

> 
>   as a followup to my previous patch (and before i build on top of
> that), perhaps someone can clarify some of these bits of curiosity:
> 
> 1) although "Sound" is listed in the Device Drivers menu, its actual
> source directory is at the top level of the kernel source tree, and
> it's the *only* entry in Device Drivers that requires sourcing from
> the top-level directory.  any reason for this?  it just kind of stands
> out as a weird exception to the rule.

sound/ (ALSA) was a replacement for the OSS sound drivers and
needed a different directory to live/work in, that's all.
They are still Device Drivers.  Don't get hung up on where
the directory is.

(part 2 omitted)

---
~Randy
