Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTLOSQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLOSQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:16:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:27560 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263768AbTLOSQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:16:33 -0500
Date: Mon, 15 Dec 2003 19:15:43 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215181543.GB11260@louise.pinerecords.com>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com> <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos> <20031215170843.GA10857@louise.pinerecords.com> <Pine.LNX.4.53.0312151258550.14778@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312151258550.14778@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-15 2003, Mon, 13:03 -0500
Richard B. Johnson <root@chaos.analogic.com> wrote:

> Therefore you make data exist in the .data segment by initializing
> it. If GCC decides to put this initialized data in the .bss segment,
> then it is broken. FYI, it doesn't.

Richard, stop denying reality, go check out what gcc 3.3.2 does.

-- 
Tomas Szepe <szepe@pinerecords.com>
