Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965459AbWFTDv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965459AbWFTDv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965460AbWFTDv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:51:27 -0400
Received: from main.gmane.org ([80.91.229.2]:41166 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965459AbWFTDv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:51:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Mon, 19 Jun 2006 20:51:09 -0700
Message-ID: <87lkrstrgy.fsf@benpfaff.org>
References: <4491BC6B.5000704@oracle.com>
	<20060619203333.5e897ead.akpm@osdl.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:BR2yAFVNugxk1V1fS47cEAZMW4Y=
Cc: linux-acpi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 15 Jun 2006 13:00:43 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
>> [UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.

>> +	{ set_max_cstate, "IBM ThinkPad R40e", {
>> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
>> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
>
> It seems that every R40e in the world is in that table.

The email says R60e.
The string says R40e.
Which is correct?
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

