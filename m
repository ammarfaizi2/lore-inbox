Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUDRLsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUDRLsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:48:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18771 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264159AbUDRLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:48:26 -0400
Date: Sun, 18 Apr 2004 05:47:29 -0600
From: Kurt Fitzner <kfitzner@excelcia.org>
Subject: Re: NFS exporting imports?
In-reply-to: <200404180317.i3I3HD3x013445@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@bitmover.com>
Message-id: <40826AD1.1030108@excelcia.org>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040402)
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <200404180317.i3I3HD3x013445@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Long ago I remember that Linux had an unusual feature wherein you could
> export /home and on the NFS server you could import something and it 
> would be exported.  It was different than other NFS servers and this was
> so long ago it may very well have been the user level NFS server code that
> did this (in fact, I'll bet it was, it makes sense).

You are talking about re-exporting a filesystem?  This is doable with 
any v3 server/client using the "nohide" option in /etc/exports.  You 
have to explicitely export all filesystem mount points that you import, 
but once you do, you can transparently switch between them on a client 
with a single mount.
