Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUDVSXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUDVSXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbUDVSXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:23:42 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59141 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264622AbUDVSXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:23:36 -0400
Message-ID: <40880E48.1000509@techsource.com>
Date: Thu, 22 Apr 2004 14:26:16 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: James Lamanna <jamesl@appliedminds.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New Radeonfb (2.6.5) driver does not play nice with X (4.3.0)
References: <4087EB5A.7040404@appliedminds.com>
In-Reply-To: <4087EB5A.7040404@appliedminds.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Lamanna wrote:
> I'm having some serious issues with the "new" radeonfb driver.
> The system boots up fine, but as soon as I start X windows,
> I cannot switch to a virtual console.
> 
> If I do, the screen goes black with what looks like lines of really
> tiny, squashed text? maybe, and the system totally hangs.
> No keyboard input, can't ssh in, totally dead.
> 
> Please CC me for I am not subscribed.
> Relevant information follows:

Are you using ATI's proprietary drivers?  I have also experienced this 
sort of system hang when using their drivers.  When I would exit the X 
server, I would get a screen full of vertical lines and the system would 
be completely dead (could not ping).

The short-term solutions are either to use the XFree's native drivers or 
to use vesafb for the console.  The long term solution is for ATI to fix 
their drivers.


