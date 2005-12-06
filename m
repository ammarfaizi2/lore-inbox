Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbVLFPPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbVLFPPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbVLFPPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:15:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:28033 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751676AbVLFPPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:15:47 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Avuton Olrich <avuton@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Machine check exception
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	<1132406652.5238.19.camel@localhost.localdomain>
	<3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	<1132436886.19692.17.camel@localhost.localdomain>
	<m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2005 12:45:44 -0700
In-Reply-To: <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
Message-ID: <p73y82yqaaf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> To decode an Opteron machine_check you can look in
> the bios and kernel programmers guide.  (Possibly the
> architecture but I think that is too generic) to see
> what all of the bits mean.

mcelog --ascii decodes the "final" machine checks output
by the 64bit kernel. The normal recoverable machine checks 
should be decoded at runtime assuming your distribution
set it up right (normally into /var/log/mcelog) 

-Andi
