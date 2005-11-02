Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVKBG2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVKBG2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVKBG2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:28:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932363AbVKBG2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:28:12 -0500
Date: Wed, 2 Nov 2005 01:27:35 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051102062735.GF16880@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
	Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>
References: <200510311606.36615.rjw@sisk.pl> <20051031113413.34a599cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031113413.34a599cd.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:34:13AM -0800, Andrew Morton wrote:

 > > Additionally there are some problems with freezing processes by swsusp.
 > More details on this?

I've seen this recently. It was kauditd refusing to freeze
for some reason.  I've not had chance to look into the code yet.

		Dave

