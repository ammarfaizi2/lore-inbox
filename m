Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267292AbUGNG2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267292AbUGNG2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUGNG2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:28:04 -0400
Received: from eis-msg-012.jpl.nasa.gov ([137.78.160.40]:2793 "EHLO
	eis-msg-012.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id S267292AbUGNG2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:28:00 -0400
Message-ID: <40F4D266.4050006@jpl.nasa.gov>
Date: Tue, 13 Jul 2004 23:27:50 -0700
From: Roy Butler <roy.butler@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:31:43PM +0200, Waldo Bastian wrote:
 >
 > The sentiment among filesystem developers seem to be that they don't 
care if
 > they trash files as long as the filesystem itself remains in a consistent
 > state. This kind of dataloss is the result of that attitude, either go
 > complain with them if it bothers you, or use a filesystem that does 
it right.
 >

Exactly.  Don't blame KDE.  Using XFS is equivalent to using 
non-battery-backed NVRAM on an external disk array.  Great if 
performance is _the_ metric and lost results can easily be regenerated 
(like in frame rendering).  By example, if you create a file, write to 
it, and then delete it fast enough, it will never hit the disk under XFS.


Roy Butler
