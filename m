Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTFQWJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbTFQWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:09:05 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:35037 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264956AbTFQWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:08:43 -0400
Date: Tue, 17 Jun 2003 18:17:58 -0400
From: Matt Reppert <repp0017@tc.umn.edu>
Subject: Re: 2.4.21 packet writing?
In-reply-to: <87d6hczgiu.fsf@complete.org>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030617181758.06203cf9.repp0017@tc.umn.edu>
Organization: Arashi no Kaze
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <87d6hczgiu.fsf@complete.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003 13:48:57 -0500
John Goerzen <jgoerzen@complete.org> wrote:
>
> Has anyone made a packet writing patch compatible with 2.4.21 that
> works with ide-scsi?
> 
> My workaround to date has been to unload the ide-scsi module and
> insert the IDE cdrom module when I want to use packet writing, and do
> the reverse when I want to use cdrecord.  It's quite annoying and I'd
> rather just use one device the whole time.

cdrecord 2.x should handle writing CDs on 2.4 kernel machines. I'm not in a
position to test that at the moment, but -checkdrive does detect the drive fine.

Matt
