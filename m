Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbUKLOZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbUKLOZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKLOZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:25:40 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:34183 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262539AbUKLOZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:25:28 -0500
Date: Fri, 12 Nov 2004 14:25:25 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: pcf8591 range list syntax
Message-ID: <20041112142525.GA19825@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

modinfo pcf8591 in 2.6.8.1 says:
"parm:           probe_range:List of adapter,start-addr,end-addr triples to
scan additionally "

when I call modprobe pcf8591 probe_range=..., what is the syntax of the list?
Are the addresses in decimal (0,255) or hexa (0,ff) or variable base
(0,0xff)?

When I want to specify 2 triples say 0,0,8 and 1,4,6 , is it
probe_range=0,0,8,1,4,6 or probe_range={0,0,8},{1,4,6} or something like
this or something completely different?

Cl<

