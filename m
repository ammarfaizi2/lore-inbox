Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDLFMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDLFMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDLFMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:12:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:54501 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbWDLFMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:12:31 -0400
To: Kirill Korotaev <dev@sw.ru>
Cc: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>
	<200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
	<4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>
	<443B873B.9040908@sw.ru>
From: Andi Kleen <ak@suse.de>
Date: 12 Apr 2006 07:12:09 +0200
In-Reply-To: <443B873B.9040908@sw.ru>
Message-ID: <p73mzer4bti.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:
> 
> Moreover, in OpenVZ live migration allows to migrate 32bit VPSs
> between i686 and x86-64 Linux machines.

How would that work when x86-64 32bit programs have 4GB of address
space and native on i386 programs only 3GB?

-Andi
