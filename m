Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263543AbVBCMb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbVBCMb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbVBCMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:31:57 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:45737 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262673AbVBCMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:31:37 -0500
Message-ID: <42021983.1000209@austin.rr.com>
Date: Thu, 03 Feb 2005 06:30:59 -0600
From: "Jonathan A. George" <jageorge@austin.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
 > ...The EXPORT_SYMBOL_GPL is a license statement to binary module 
developers...
<snip>

As noted repeatedly a symbol prefix doesn't appear to carry any legal 
weight under U.S. law.  In fact the GPL copyright notice is appear 
legally limited to the granting of *copy* *rights* per U.S. copyright 
law and specifically does _not_ appear to implicitly or explicitly 
create the kind of exceptions you seem to be looking for.


 > The one major stumbling block is that any code that imports symbols
 > that are exported via "EXPORT_SYMBOL_GPL" can only legally _export_
 > symbols using the same, for the reason I stated above.

The GPL as a *copy* *right* notice can apparently only apply obviously 
derivative works under U.S. law, and an independent driver created for a 
different OS is obviously _not_ a derivative work.  Basically the 
attempt to create such a distinction does not appear to be supported by 
U.S. law as applied to the GPL.

 > If it's a non-GPL module it _cannot_ legally use EXPORT_SYMBOL_GPLed
 > symbols, either directly or indirectly, under any circumstances.

Actually you can probably use any symbols you want since only the glue 
layer to the OS independent driver is would appear derivative of Linux, 
and since the glue layer appears to be derivative of two *independent* 
works (the OS and the Driver when done this way) you might need to 
license the glue layer in a way which is compatible with both works.  
The current BSD license could be a good choice in this instance.

** As noted previously it would be interested to see the opinion of a 
U.S. IP lawyer who has conclusively tested the impact of copy right law 
where the boundary of what constitutes a derivative work was explicitly 
stated by a federal judge.

-----------------

P.S. Consider a kernel module which allows the use of a binary only 
MS-Windows driver in its unmodified stated.  Could you actually consider 
the MS-Windows driver to be a derivative work of the Linux kernel by 
virtue of an intermediate glue module which was BSD licensed and made 
free use of all symbols?  Would the Linux kernel be considered a 
derivative work of your motherboards firmware?  These seem rather 
unlikely conclusions.
