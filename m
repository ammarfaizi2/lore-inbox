Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUKCOtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUKCOtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKCOtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:49:50 -0500
Received: from main.gmane.org ([80.91.229.2]:31468 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261618AbUKCOti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:49:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 03 Nov 2004 15:49:06 +0100
Message-ID: <yw1xis8nhtst.fsf@ford.inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.80-202-166.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:dhFP9gd7wJ+pU0nh6eyjfjI+xT8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
>
>> But I'd tried to run gnomeradio earlier to listen to the elections, 
>
> Depressing enough.
>
>> I'd tried to kill the zombie earlier but couldn't.
>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>
> Kill the parent, is the only (portable) way.

Perhaps not as portable, but another possible, though slightly
complicated, way is to ptrace the parent and force it to wait().

-- 
Måns Rullgård
mru@inprovide.com

