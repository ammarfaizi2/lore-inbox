Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUBBXFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUBBXFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:05:47 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:35829 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265271AbUBBXFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:05:46 -0500
Date: Tue, 3 Feb 2004 00:05:42 +0100
To: John <jgluckca@netscape.net>, linux-kernel@vger.kernel.org
Subject: Re: ACPI and laptop question
Message-ID: <20040202230542.GA25362@fubini.pci.uni-heidelberg.de>
References: <182E8021.2C94112E.009D6C5C@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182E8021.2C94112E.009D6C5C@netscape.net>
User-Agent: Mutt/1.3.28i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, the root filesystem check is done before /proc is mounted, so that won't work.
> 

But the root filesystem is checked from a script. So you would only need
to change that script to mount /proc before performing the check.

Cheers,
	Bernd
