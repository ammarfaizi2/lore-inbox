Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJHL6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 07:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJHL6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 07:58:22 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:44834 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261380AbTJHL6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 07:58:21 -0400
Date: Wed, 8 Oct 2003 12:57:43 +0100
From: Dave Jones <davej@redhat.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.0-test6 - 2003-10-07.18.30) - 4 New warnings (gcc 3.2.2)
Message-ID: <20031008115742.GE705@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
References: <200310080634.h986Y3aH006384@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310080634.h986Y3aH006384@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 11:34:03PM -0700, John Cherry wrote:
 > arch/i386/kernel/cpu/cpufreq/longhaul.h:237: warning: `nehemiah_clock_ratio' defined but not used
 > arch/i386/kernel/cpu/cpufreq/longhaul.h:273: warning: `nehemiah_eblcr' defined but not used

incomplete merge. It's there for the VIA folks to sync against.
I'll comment them out in the next push for the time being.

 > arch/i386/kernel/cpu/cpufreq/powernow-k8.c:938:2: warning: #warning pol->policy is in undefined state here

needs fixing.
 
		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
