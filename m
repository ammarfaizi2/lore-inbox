Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWGYAZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWGYAZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWGYAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:25:27 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:33989 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932353AbWGYAZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:25:27 -0400
Date: Mon, 24 Jul 2006 20:21:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: remove cpu hotplug bustification in cpufreq.
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1153738326.3043.13.camel@laptopd505.fenrus.org>

On Mon, 24 Jul 2006 12:52:05 +0200, Arjan van de Ven wrote:
> 
> > What kind of _crap_ is this cpufreq thing?
> 
> this is why lockdep got highly upset with it, and why Davej proposed to
> remove the locking entirely for now until it can be put back in a
> correct way....

I thought just the 'ondemand' governor was a problem?

That thing has been broken since day 1 AFAICT.  There are lots of
reports of problems with it on the list.

-- 
Chuck

