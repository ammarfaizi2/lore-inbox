Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTI1MIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTI1MIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:08:46 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:9420 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262461AbTI1MIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:08:45 -0400
Date: Sun, 28 Sep 2003 14:05:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Zhang Jian <jzhang001@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: urgent! help, ide driver bug?
Message-ID: <20030928120533.GC9770@louise.pinerecords.com>
References: <LAW11-F66x33E1ioWwr00014013@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW11-F66x33E1ioWwr00014013@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jzhang001@hotmail.com]
> 
> Attempt to access beyond end of device
> 03:02: rw=0, want=75368548, limit=7815622

This error is coming from the block layer, typically as a result
of a filesystem code bug or corruption.  Try using a different
kind of filesystem for your setup (for instance reiserfs or jfs)
to see if your problem is rooted in the ext2 filesystem code.

-- 
Tomas Szepe <szepe@pinerecords.com>
