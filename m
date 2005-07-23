Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVGWIOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVGWIOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 04:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGWIOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 04:14:01 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:39332 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261558AbVGWIOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 04:14:00 -0400
Date: Sat, 23 Jul 2005 04:10:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] turn many #if $undefined_string into #ifdef
  $undefined_string
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>
Message-ID: <200507230413_MC3-1-A559-7852@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 at 16:48:05 +0200, Olaf Hering wrote:

> turn many #if $undefined_string into #ifdef $undefined_string
> to fix some warnings after -Wno-def was added to global CFLAGS


 Shouldn't that be "#if defined($undefined_string)"?

 #ifdef is obsolete...

__
Chuck
