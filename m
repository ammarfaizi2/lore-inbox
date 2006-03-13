Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWCMTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWCMTdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWCMTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:33:44 -0500
Received: from xenotime.net ([66.160.160.81]:24298 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932340AbWCMTdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:33:43 -0500
Date: Mon, 13 Mar 2006 11:35:29 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Doc/kernel-parameters.txt: slightly reword sentence
 about restrictions
Message-Id: <20060313113529.4f18772a.rdunlap@xenotime.net>
In-Reply-To: <tkrat.db45898acb8b4e93@s5r6.in-berlin.de>
References: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
	<tkrat.fb495404c563eaf7@s5r6.in-berlin.de>
	<tkrat.db45898acb8b4e93@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 20:23:17 +0100 (CET) Stefan Richter wrote:

> Doc/kernel-parameters.txt: slightly reword sentence about restrictions
> 
> The previous patch somewhat diverted the train of thought.
> Here I am trying to bring the valued reader back on track.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> --- linux/Documentation/kernel-parameters.txt.2	2006-03-13 19:57:52.000000000 +0100
> +++ linux/Documentation/kernel-parameters.txt	2006-03-13 20:03:32.000000000 +0100
> @@ -24,9 +24,10 @@
>  parameters may be changed at runtime by the command
>  "echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
>  
> -The text in square brackets at the beginning of the description states the
> -restrictions on the kernel for the said kernel parameter to be valid. The
> -restrictions referred to are that the relevant option is valid if:
> +The parameters listed below are only valid if certain kernel build options were
> +enabled and if respective hardware is present. The text in square brackets at
> +the beginning of each description states the restrictions within wich a
> +parameter is applicable:

within which


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
