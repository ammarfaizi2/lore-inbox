Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbTGVBf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbTGVBf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:35:26 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:21892
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S267471AbTGVBfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:35:24 -0400
Date: Mon, 21 Jul 2003 21:49:40 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Samuel Flory <sflory@rackable.com>
cc: Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 won't go further than "uncompressing" on a p1/32MB
      pc
In-Reply-To: <3F1C8739.2030707@rackable.com>
Message-ID: <Pine.LNX.4.44.0307212148350.5508-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003, Samuel Flory wrote:

>   However a "make oldconfig" on a 2.4 .config doesn't pick this up.  In 
> fact it appears to be impossible to select  CONFIG_VT  CONFIG_VT_CONSOLE 
> in make menuconfig.

Before you can select those options in menuconfig you need to set 
CONFIG_INPUT to be y

