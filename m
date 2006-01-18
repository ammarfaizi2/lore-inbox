Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWARDBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWARDBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWARDBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:01:39 -0500
Received: from free.wgops.com ([69.51.116.66]:40202 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S964874AbWARDBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:01:39 -0500
Date: Tue, 17 Jan 2006 20:01:29 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <4B3A20965B8B96960504A5C8@dhcp-2-206.wgops.com>
In-Reply-To: <43CDA3B0.2030503@cfl.rr.com>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
 <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
 <43CD8A19.3010100@cfl.rr.com>
 <7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
 <43CDA3B0.2030503@cfl.rr.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 17, 2006 9:10:56 PM -0500 Phillip Susi <psusi@cfl.rr.com> 
wrote:

> I understood you to be saying that a raid-5 was less reliable than a
> single disk, which it is not.  Maybe I did not read correctly.  Yes, a 3
> + n disk raid-5 has a higher chance of failure than a 3 disk raid-5, but
> only slightly so, and in any case, a 3 disk raid-5 is FAR more reliable
> than a single drive, and only slightly less reliable than a two disk
> raid-1 ( though you get 3x the space for only 50% higher cost, so 6x
> cheaper cost per byte of storage ).


Yup we're on the same page, we just didn't think we were.  It happens :) 
R-5 (in theory) could be less reliable than a mirror or possibly a single 
drive, but it'd take a pretty obscene number of drives with excessively 
large strip size.
