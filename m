Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTDWJZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTDWJZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:25:14 -0400
Received: from ns.suse.de ([213.95.15.193]:530 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263989AbTDWJZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:25:12 -0400
Date: Wed, 23 Apr 2003 11:33:55 +0200
From: Olaf Hering <olh@suse.de>
To: Julien Oster <frodo@dereference.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030423113355.A32678@suse.de>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Apr 22, Julien Oster wrote:

> My question now is: Why? I often saw things in the kernel ring buffer
> which I don't want every user to know (e.g. some telephone numbers with
> ISDN).

This is a bug in the kernel ISDN code. The userspace daemon must log it
to syslog, these messages do not belong to the dmesg buffer.

-- 
USB is for mice, FireWire is for men!
