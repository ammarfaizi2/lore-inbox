Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUDHIDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbUDHIDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:03:11 -0400
Received: from quimby.programmfabrik.de ([193.108.181.138]:28690 "EHLO
	quimby.programmfabrik.de") by vger.kernel.org with ESMTP
	id S263146AbUDHIDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:03:08 -0400
Subject: Re: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
From: Martin Rode <martin.rode@zeroscale.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081365374.11164.24.camel@shaggy.austin.ibm.com>
References: <1081359310.1212.537.camel@marge.pf-berlin.de>
	 <1081365374.11164.24.camel@shaggy.austin.ibm.com>
Content-Type: text/plain
Organization: Zeroscale GmbH & Co.
Message-Id: <1081410996.3770.1405.camel@marge.pf-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Apr 2004 09:56:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 21:16, Dave Kleikamp wrote:
> On Wed, 2004-04-07 at 12:35, Martin Rode wrote:
> > 5) cp fails
> > apu:/home/martin/tmp/bug# (cd alpha/beta; cp ../latest/myfile .)
> > cp: cannot stat `../latest/myfile': No such file or directory
> 
> When you cd to alpha/beta, your current directory is really
> .../tmp/bug/beta.  Your shell may remember that you got there through
> the symlink in alpha, but cp will follow .., which is really bug.

Bug in "cp", "bash" or in the kernel fs-layer? 

Martin

-- 
Zeroscale GmbH & Co.
Game Development

