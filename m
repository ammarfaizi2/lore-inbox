Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUFWBGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUFWBGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUFWBGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:06:50 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:41933 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265214AbUFWBGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:06:41 -0400
Date: Tue, 22 Jun 2004 20:37:13 -0400
From: Ben Collins <bcollins@debian.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394: unsolicited response packet received - no tlabel match
Message-ID: <20040623003713.GB3747@phunnypharm.org>
References: <20040622213830.GA11770@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622213830.GA11770@codeblau.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 11:38:30PM +0200, Felix von Leitner wrote:
> This is an excerpt from my dmesg.  I am using a large Maxtor firewire
> hard disk as VCR storage.  This happens only when I read large files
> from the external firewire disk, not when watching an AVI movie on it

Could you try setting sbp2_max_speed to 1 or 0 and see if that
alleviates the problem? I know that's not an fix, but I want to see
which of two different problems we are working with.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
