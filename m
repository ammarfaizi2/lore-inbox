Return-Path: <linux-kernel-owner+w=401wt.eu-S932903AbXABSEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbXABSEd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbXABSEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:04:33 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:13769 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932903AbXABSEc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:04:32 -0500
Date: Tue, 2 Jan 2007 18:04:25 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-ID: <20070102180425.GA18680@deepthought>
References: <20070101160158.GA26547@deepthought> <200701021225.57708.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200701021225.57708.lenb@kernel.org>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 12:25:57PM -0500, Len Brown wrote:
> > it's been nothing but trouble in 32-bit mode.
> > It still works fine when I boot it in 64-bit mode. 
> 
> A shot in the dark at the spontaneous reset issue, but no clue on the 32 vs 64-bit observation...
> 
> See if ACPI exports any temperature readings under /proc/acpi/thermal_zone/*/temperature
> and if so, keep an eye on them to see if there is an indication of a thermal problem.
> 
> ( And if ACPI doesn't, maybe lmsensors can find something.)
> 
> cheers,
> -Len

 Thanks, but there is nothing there.  I never managed to get
lmsensors configured (as in 'calibrated') for the hardware I tried it
on, but I was starting to think about retrying it.  But first, I'm
just about to start testing with memtest86+ in case something in the
memory has gone bad.

ĸen
-- 
das eine Mal als Tragödie, das andere Mal als Farce
