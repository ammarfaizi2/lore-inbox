Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVGRLOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVGRLOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVGRLOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:14:31 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:12503 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261305AbVGRLOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:14:30 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Kernel Panic: VFS cannot open a root device
Date: Mon, 18 Jul 2005 07:14:41 -0400
User-Agent: KMail/1.8.1
Cc: "porranenhuma@globo.com" <porranenhuma@globo.com>,
       Norbert van Nobelen <norbert@edusupport.nl>,
       linux-kernel@vger.kernel.org
References: <200507171016.37940.norbert@edusupport.nl> <428C48BA000CBFCB@riosf03.globoi.com> <1e62d13705071719462d437a21@mail.gmail.com>
In-Reply-To: <1e62d13705071719462d437a21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507180714.41939.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 July 2005 22:46, Fawad Lateef wrote:
> I saw this prob when my boot device/partition in the bootloader config
> was wrong or the filesystem of my root partition is not compiled as a
> kernel image rather compiled as module, so plz try to solve this prob
> by selecting your desired filesystem in kernel configuration as Y
> rather than M ...... I hope this will work

One further tip.  Make your root FS's type the only one that is not a module.
Once you have it booting then, if you want, flip other FSes to in kernel.

Ed Tomlinson
