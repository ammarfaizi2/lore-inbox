Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbTISNKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTISNKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:10:32 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:3297 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261551AbTISNKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:10:31 -0400
Date: Fri, 19 Sep 2003 14:09:25 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tossati <marcelo.tosatti@cyclades.com.br>, m.c.p@wolk-project.de
Subject: Re: [PATCH] Allow sysrq() via /proc/sys/kernel/magickey
Message-ID: <20030919130925.GA21000@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>,
	m.c.p@wolk-project.de
References: <200308252003.h7PK3EQq024312@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308252003.h7PK3EQq024312@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 07:42:57PM +0000, Linux Kernel wrote:
 > ChangeSet 1.1114, 2003/08/25 16:42:57-03:00, m.c.p@wolk-project.de
 > 
 > 	[PATCH] Allow sysrq() via /proc/sys/kernel/magickey
 > 	
 > 	Hi Marcelo,
 > 	
 > 	sysrq() is a good thing to debug things, but unfortunately you need to have
 > 	physical access to the keyboard. My company for instance maintains tons of
 > 	remote machines and sometimes we need to do sysrq() too, but it's not
 > 	possible to do so the remote way.
 > 	
 > 	Attached patch enables emulation of the Magic SysRq key (Alt-SysRq-key) via
 > 	the /proc interface. Just echo the desired character into the file and there
 > 	you go.
 > 	
 > 	Patch from Randy Dunlap!
 > 	
 > 	It's in -wolk for a long time and also in some other kernel tree forks.
 > 	2.5/2.6 has almost the same (/proc/sysrq-trigger)

So why not make this compatible with existing behaviour, and use the
same name ? Seems this is deviating between 2.4 / 2.6 for no good reason.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
