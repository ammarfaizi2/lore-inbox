Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbULLM6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbULLM6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 07:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbULLM6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 07:58:43 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:50085 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262071AbULLM6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 07:58:41 -0500
Date: Sun, 12 Dec 2004 13:58:41 +0100
From: bert hubert <ahu@ds9a.nl>
To: cranium2003 <cranium2003@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc query
Message-ID: <20041212125840.GA15826@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	cranium2003 <cranium2003@yahoo.com>, linux-kernel@vger.kernel.org
References: <20041211025014.34677.qmail@web41409.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211025014.34677.qmail@web41409.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:50:14PM -0800, cranium2003 wrote:
> Can a user program be able to overwrite /proc entry
> with some changes to that /proc file frequently?
> can same file be able to read by kernel in its actual
> kernel execution?

Userspace can only set settings in the kernel when the kernel allows this.
Procfs is not a storage filesystem, it stores settings and exposes
information.

The kernel does not 'read' files in /proc per se, it has direct access to
the relevant settings.

Procfs is like a window on the kernel, and in some cases you can hand the
kernel new settings.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
