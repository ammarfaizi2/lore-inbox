Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVE3XZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVE3XZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVE3XXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:23:23 -0400
Received: from main.gmane.org ([80.91.229.2]:14524 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261829AbVE3XW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:22:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Tue, 31 May 2005 01:20:05 +0200
Message-ID: <yw1xacmcjo7u.fsf@ford.inprovide.com>
References: <4847F-8q-23@gated-at.bofh.it> <d120d500050527072146c2e5ee@mail.gmail.com>
 <429AD7ED.nail4ZG1B42TI@burner>
 <200505301727.43926.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:BoBzaojbSlL1Yb+uxadcchOGS34=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> writes:

>> So let me sum up: Never rely on things that cannot be made 100%
>> unique in case you like to run security relevent software like cdrecord.
>
> Are you talking about <bus>,<target>,<lun> numbering by any chance ;) ?
> Because for the most types of devices out there they don't make any sense
> and just provided for compatibility with legacy software.

Like cdrecord.

> Also, from a bit different perspective - do you also want users to mount
> the CD they burnt using not device (/dev/xxx) but <bus>,<target>,<lun>?
> If not why writing application should use different addressing? 

Let's start referring to files by device and inode number instead.
It's so much easier than using pathnames.  Maybe we can even force
them into a bus,target,lun scheme.  Then the device files and the
corresponding scsi addresses will automatically collapse, and all
problems will be solved.

-- 
Måns Rullgård
mru@inprovide.com

