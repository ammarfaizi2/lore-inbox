Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVIWIK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVIWIK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVIWIK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:10:57 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:5056 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750801AbVIWIK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:10:56 -0400
Date: Fri, 23 Sep 2005 04:07:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: x86-64: Why minimum 64MB aperture?
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509230410_MC3-1-AAFB-6FC6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when I boot:

Checking aperture...
CPU 0: aperture @ 23a8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)


arch/x86_64/aperture.c says this when aperture is < 64MB.

I have no way of changing this in my BIOS.  The systems shares video memory
with RAM.  All I can change is the amount of RAM allocated for video (32, 64
or 128 MB, currently set to 64.)

__
Chuck
