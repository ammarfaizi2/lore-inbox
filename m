Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTILSlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTILSlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:41:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64920 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261844AbTILSkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:40:11 -0400
Message-ID: <3F6212FD.5000702@pobox.com>
Date: Fri, 12 Sep 2003 14:39:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Adrian Bunk <bunk@fs.tum.de>, ebiederm@xmission.com, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>	<20030911012708.GD3134@wotan.suse.de>	<20030910184414.7850be57.akpm@osdl.org>	<20030911014716.GG3134@wotan.suse.de>	<3F60837D.7000209@pobox.com>	<20030911162634.64438c7d.ak@suse.de>	<3F6087FC.7090508@pobox.com>	<m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>	<20030912195606.24e73086.ak@suse.de>	<3F62098F.9030300@pobox.com>	<20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de>
In-Reply-To: <20030912202851.3529e7e7.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> That's obsolete and could be removed. All 3dnow! code is dynamically patched depending on the CPUID.


Ug.  Why compile in 3dnow code when you don't need it?  There is a 
sizeable number of processors without 3dnow...

	Jeff



