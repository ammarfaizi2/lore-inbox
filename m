Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCKOwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUCKOue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:50:34 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:5336 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261378AbUCKOti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:49:38 -0500
Subject: Re: [PATCH] Light-weight Auditing Framework
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Rik Faith <faith@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <16464.30442.852919.24605@neuro.alephnull.com>
References: <16464.30442.852919.24605@neuro.alephnull.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1079016557.5752.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 11 Mar 2004 09:49:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 09:25, Rik Faith wrote:
> Below is a patch against 2.6.4 that provides a low-overhead system-call
> auditing framework for Linux that is usable by LSM components (e.g.,
> SELinux).  This is an update of the patch discussed in this thread:
>     http://marc.theaimsgroup.com/?t=107815888100001&r=1&w=2

Just FYI, I have no objection to the changes in this patch to the
SELinux module; we would be glad to have SELinux use this auditing
framework if it is accepted into the mainline kernel.  I suppose we can
separately submit a patch to remove the avc_ratelimit code from the
SELinux avc, as that should be handled by the audit framework itself.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

