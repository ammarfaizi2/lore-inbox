Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTLIAA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTLIAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:00:28 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:22937 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261909AbTLIAA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:00:27 -0500
Date: Mon, 8 Dec 2003 16:00:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031209000021.GA8402@mis-mike-wstn.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I'm working on a script that reads /proc/meminfo, and it has two modes for
reading the file.

One that reads the first column to get the name, and gets the value in an
array, and the other just reads the Mem: and Swap: lines and parses the info
out.

Now I need to change the order (it is using Mem: and Swap: first, and the
other more thurough method second), but I'm wondering what versions of the
kernel I'd be cutting out if I just removed the parsing of Mem: and Swap:...

All of the systems I have available are running 2.4, and instead of booting
a bunch of 2.2, or even 2.0 or earlier kernels, maybe some lkml readers
recall from memory? :)

TIA,

Mike
