Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWALWSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWALWSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161365AbWALWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:18:08 -0500
Received: from topaz.mcs.anl.gov ([140.221.57.209]:5016 "EHLO topaz")
	by vger.kernel.org with ESMTP id S1161364AbWALWSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:18:07 -0500
From: Narayan Desai <desai@mcs.anl.gov>
To: Alexander Wagner <a.wagner@physik.uni-wuerzburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[4,5]: battery info lost
References: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
Date: Thu, 12 Jan 2006 16:18:04 -0600
In-Reply-To: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
	(Alexander Wagner's message of "Thu, 12 Jan 2006 18:37:52 +0100")
Message-ID: <87mzi1ay5f.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that disabling CONFIG_PREEMPT fixed the problems for me. A
co-worker reported (today, coincidentally) that using the
acpi_serialize kernel option seems to have fixed the problem for him.
 -nld
