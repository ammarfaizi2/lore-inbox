Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUAVUdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUAVUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:33:38 -0500
Received: from nevyn.them.org ([66.93.172.17]:59042 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266496AbUAVUdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:33:07 -0500
Date: Thu, 22 Jan 2004 15:33:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040122203304.GA13377@nevyn.them.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <20040121183940.GA23200@nevyn.them.org> <200401221119.24021.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401221119.24021.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:19:23AM +0530, Amit S. Kale wrote:
> CONFIG_KGDB_THREAD save code will still be required on other processors. 
> Powerpc for example has _switch assembly function that does a lot of things, 
> including saving registers on stack.

Then this can also be described using dwarf2 annotation.  This is
precisely what it's for.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
