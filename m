Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUKRVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUKRVrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUKRVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:45:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51338 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263009AbUKRVol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:44:41 -0500
Date: Thu, 18 Nov 2004 16:44:31 -0500
From: Dave Jones <davej@redhat.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e820 and shared VGA memory problem
Message-ID: <20041118214431.GC1347@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
References: <aec7e5c304111813202f74a139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c304111813202f74a139@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:20:48PM +0100, Magnus Damm wrote:

 > So, the CMOS setup, the BIOS changelog, the e820 data all seem to
 > think that 16 MiB are used as VGA RAM. But I suspect that the extreme
 > slowdowns are because 32 MiB VGA RAM is used.  Any ideas? Is the BIOS
 > funky, or are we doing something wrong in the kernel?

In the past such problems have been attributed to BIOS's not
setting up MTRRs correctly, or in extreme situations, running
out of available MTRRS.  How does /proc/mtrr look ?

		Dave
