Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWCBMML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWCBMML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCBMMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:12:10 -0500
Received: from mail.suse.de ([195.135.220.2]:11220 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751164AbWCBMMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:12:09 -0500
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 13:14:04 +0100
User-Agent: KMail/1.9.1
Cc: "Dave Jones" <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021314.04601.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 06:49, Brown, Len wrote:

> I'm afraid that even after we get this stuff out of /proc
> and into sysfs where it belongs, we'll have to leave /proc/acpi around
> for a while b/c unfortunately people are under the impression
> that the path names there actually mean something and
> they can actually count on them -- which they can't.

But they should. Once you provide an interface here you 
have to provide it essentially forever. Or at least if you really
change it use a very long deprecation period, but even that 
is a bad thing to do to users.

-Andi
