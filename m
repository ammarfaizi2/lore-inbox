Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbTDCIok>; Thu, 3 Apr 2003 03:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbTDCIok>; Thu, 3 Apr 2003 03:44:40 -0500
Received: from holomorphy.com ([66.224.33.161]:29834 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263261AbTDCIoj>;
	Thu, 3 Apr 2003 03:44:39 -0500
Date: Thu, 3 Apr 2003 00:55:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: isp1020 memory trample in 2.5.66
Message-ID: <20030403085545.GB19627@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <Pine.LNX.4.50.0304020101460.8773-100000@montezuma.mastecende.com> <20030402080226.A25288@beaverton.ibm.com> <Pine.LNX.4.50.0304030317230.30262-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0304030317230.30262-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Patrick Mansfield wrote:
>> Martin hit it when the queue depth was not properly checked.
>> wli has hit it with parallel mkfs (or something).

On Thu, Apr 03, 2003 at 03:27:38AM -0500, Zwane Mwaikambo wrote:
> Ok this thing sounds _very_ fragile ;)

Debugging ode this obfuscated and crappy is as hopeless as trying to
debug the nvidia binary-only oops-o-rama.

What are the odds of just throwing away the isp1020 and replacing it
with anything else? It won't fix it, but it can't be fixed due to
utter lack of information about the things and/or lack of maintainers
with information hidden by NDA's anyway.


-- wli
