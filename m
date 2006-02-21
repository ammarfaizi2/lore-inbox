Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWBUSZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWBUSZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWBUSZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:25:49 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:23014 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932387AbWBUSZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:25:48 -0500
Date: Tue, 21 Feb 2006 13:14:59 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc4-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602211318_MC3-1-B8E8-E64E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>

On Mon, 20 Feb 2006 at 04:26:15 -0800, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/

Could you merge my trivial patches?

i386-allow-disabling-x86_feature_sep-at-boot.patch
        I keep having to backport this one because I need it for testing mainline.

i386-__devinit-should-be-__cpuinit.patch
        Saves a few K when HOTPLUG && !HOTPLUG_CPU

i386-fall-back-to-sensible-cpu-model-name.patch
        Rohit signed off on this one.

kbuild-add-fverbose-asm-to-i386-makefile.patch
        Nice to have and does this for all archs, not just i386.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
