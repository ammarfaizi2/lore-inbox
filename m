Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752311AbWAFADF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbWAFADF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbWAFADE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:03:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752308AbWAFAC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:02:58 -0500
Date: Thu, 5 Jan 2006 16:02:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] boot with Gujin: add script/{gzcopy.c,gzparam.c} to
 generate linux.kgz file format
Message-Id: <20060105160244.5e9df486.akpm@osdl.org>
In-Reply-To: <20060105230312.32885.qmail@web26909.mail.ukl.yahoo.com>
References: <20060105230312.32885.qmail@web26909.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:
>
> So this patch create a file script/gzcopy.c and Makefile rules to produce
>  script/gzcopy which can be use to view, change (set/append/prepend) comment
>  to GZIP files. Type "./script/gzcopy --help" for a list of switches.
>  This first file (and only this one) is released under a BSD license to
>  enable anybody else to add it in a "GZIP distribution" if needed,
>  it follow special rules for indentation and a special way to define
>  strings so that localisation should be simpler.
> 
>   This patch also contains the simple script/gzparam.c file and its
>  Makefile rules - that is a simple standalone program to display a text
>  line on stdout containing the base pattern to generate the GZIP comment
>  itself for this configured kernel.

Those sound like things which should be distributed in the gzip package,
not in the kernel source tree?
