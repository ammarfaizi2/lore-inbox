Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWGFSAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWGFSAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWGFSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:00:09 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:13587 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030375AbWGFSAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:00:07 -0400
Message-ID: <44AD4FA1.2060200@argo.co.il>
Date: Thu, 06 Jul 2006 21:00:01 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
References: <e1e1d5f40607051003v6b644e82p346c6e0661f39274@mail.gmail.com>
In-Reply-To: <e1e1d5f40607051003v6b644e82p346c6e0661f39274@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2006 18:00:05.0476 (UTC) FILETIME=[02D1A240:01C6A126]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
>
> Got a " You are not authorized to access bug #190296. To see this bug,
> you must first log in to an account with the appropriate permissions."
> on the referred bugzilla page.
>
> What kind of symbol uses more than 127 characters, anyways ?
>

Maybe C++ mangled names.

I've seen names longer than early machines' main memory.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

