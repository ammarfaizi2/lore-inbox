Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTE0Cxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTE0Cxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:53:30 -0400
Received: from vitelus.com ([64.81.243.207]:60428 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262620AbTE0Cxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:53:30 -0400
Date: Mon, 26 May 2003 20:02:19 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
Message-ID: <20030527030219.GI9947@vitelus.com>
References: <3ED2AEA9.1000401@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED2AEA9.1000401@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:17:45AM +0200, Carl-Daniel Hailfinger wrote:
> > +CHECK		= /home/torvalds/parser/check
> 
> Hardcoded path

Well, the checker its share of those problems:

const char *gcc_includepath[] = {
    "/usr/lib/gcc-lib/i386-redhat-linux/3.2.1/include",
    "/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include",
    NULL
};
