Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHSJva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHSJva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHSJvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:51:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:44218 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264795AbUHSJrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:47:41 -0400
To: "Pankaj Agarwal" <pankaj@pnpexports.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to identify filesystem type
References: <001901c485cc$208c3a60$9159023d@dreammachine>
From: Andreas Schwab <schwab@suse.de>
X-Yow: You mean you don't want to watch WRESTLING from ATLANTA?
Date: Thu, 19 Aug 2004 11:46:42 +0200
In-Reply-To: <001901c485cc$208c3a60$9159023d@dreammachine> (Pankaj Agarwal's
 message of "Thu, 19 Aug 2004 14:37:44 +0530")
Message-ID: <je657fzchp.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pankaj Agarwal" <pankaj@pnpexports.com> writes:

> I need your help, in understanding filesystems. Kindly let me know how to
> identify the filesystem in an image file or block device.

Use file:

# file -s /dev/hda3
/dev/hda3: ReiserFS V3.6 block size 4096 (mounted or unclean) num blocks 9500285 r5 hash

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
