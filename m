Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVHXDle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVHXDle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVHXDle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:41:34 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:7330 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932148AbVHXDld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:41:33 -0400
Message-ID: <430BEBEA.60704@austin.rr.com>
Date: Tue, 23 Aug 2005 22:39:22 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jerry@samba.org,
       samba-technical@lists.samba.org, linux-cifs-client@lists.samba.org,
       raven@themaw.net
Subject: Re: New maintainer needed for the Linux smb filesystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - good progress on filling the requirement for Windows ME/9x support 
which seems to be the most common reason for still needing smbfs based 
on various email responses on this thread (if we can get this work 
finished up fast, it will avoid some double maintainence).

CIFS (in the cifs.git tree) can now handle not just mounts to Windows ME 
(and probably Windows 9x), but readdir and enough of lookup.   Finishing 
up the remainder should go fast (OpenX instead of NTCreateX is the main 
piece left).

Of course finding Windows 95, Windows 98, and OS/2 servers is a little 
harder than it sounds...although scripting a subset of the functional 
tests that should work should be pretty easy.

I will also put a version of the source that will compile at least as 
far back as 2.6.9 up on the project page within a few days.


