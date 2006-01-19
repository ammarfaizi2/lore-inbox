Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWASAiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWASAiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWASAiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:38:05 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:2725 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161104AbWASAiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:38:04 -0500
Date: Wed, 18 Jan 2006 19:36:00 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack
  backtraces
To: Pavel Machek <pavel@ucw.cz>
Cc: Keith Owens <kaos@ocs.com.au>, mita@miraclelinux.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-ID: <200601181937_MC3-1-B627-6D56@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060118224732.GA1812@elf.ucw.cz>

On Wed, 18 Jan 2006, Pavel Machek wrote:

> I also believe that oops dump is so closely tied
> to kernel that it is fair to change... plus this should better not be
> configurable, or userspace will have hard time parsing it.

Userspace will still have to cope with the old format anyway.

I'll send a patch to change the default to two columns so the
new format gets some exposure, though.

-- 
Chuck
Currently reading: _Noise_ by Hal Clement
