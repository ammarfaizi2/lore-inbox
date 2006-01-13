Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWAMFyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWAMFyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 00:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWAMFyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 00:54:24 -0500
Received: from fmr19.intel.com ([134.134.136.18]:41923 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161368AbWAMFyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 00:54:24 -0500
From: Yu Luming <luming.yu@intel.com>
Organization: Intel
To: Narayan Desai <desai@mcs.anl.gov>
Subject: Re: 2.6.1[4,5]: battery info lost
Date: Fri, 13 Jan 2006 13:55:36 +0800
User-Agent: KMail/1.8.2
Cc: Alexander Wagner <a.wagner@physik.uni-wuerzburg.de>,
       linux-kernel@vger.kernel.org
References: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de> <87mzi1ay5f.fsf@topaz.mcs.anl.gov>
In-Reply-To: <87mzi1ay5f.fsf@topaz.mcs.anl.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131355.36958.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 06:18, Narayan Desai wrote:
> I found that disabling CONFIG_PREEMPT fixed the problems for me. A
> co-worker reported (today, coincidentally) that using the
> acpi_serialize kernel option seems to have fixed the problem for him.
>  -nld
Please try patch http://bugzilla.kernel.org/show_bug.cgi?id=4588#c31
when PREEMPT enabled.
-- 
Thanks,
Luming
