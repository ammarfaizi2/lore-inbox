Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWJVRSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWJVRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWJVRSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:18:16 -0400
Received: from xenotime.net ([66.160.160.81]:60389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751316AbWJVRSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:18:15 -0400
Date: Sun, 22 Oct 2006 10:19:53 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MODVERSION
Message-Id: <20061022101953.23d3b7c5.rdunlap@xenotime.net>
In-Reply-To: <20061022165215.17075.qmail@web27408.mail.ukl.yahoo.com>
References: <20061022165215.17075.qmail@web27408.mail.ukl.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 17:52:15 +0100 (BST) ranjith kumar wrote:

> How to set config_modversion on/off.
> 
> I am asking this question because I got the following
> error when I tried to insert a modeule which I wrote.
> 
> deogiri:/users/pg05/ranjithk/Desktop/prg#   gcc -c 3.c
> deogiri:/users/pg05/ranjithk/Desktop/prg#   insmod
> ./3.o
> insmod: error inserting './3.o': -1 Invalid module
> format
> 
> Can any one help me?

Is this for a 2.6 kernel?
If so, you need to build a 3.ko file, using the 2.6 kbuild
infrastructure.  See Documentation/kbuild/* for doc & examples.

Your error messages isn't a modversions error, but you can
easily enable or disable modversions using make <your_favorite>config.
It's listed under the "Loadable module support" menu.

---
~Randy
