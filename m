Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUILN6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUILN6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268729AbUILN6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:58:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268728AbUILN6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:58:12 -0400
Date: Sun, 12 Sep 2004 09:58:01 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <joq@io.com>,
       <torbenh@gmx.de>
Subject: Re: [PATCH] Realtime LSM
In-Reply-To: <1094967978.1306.401.camel@krustophenia.net>
Message-ID: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Lee Revell wrote:

> +config SECURITY_REALTIME
> +	tristate "Realtime Capabilities"
> +	depends on SECURITY && SECURITY_CAPABILITIES!=y
> +	default n
> +	help
> +	  Answer M to build realtime support as a Linux Security
> +	  Module.  Answering Y to build realtime capabilities into the
> +	  kernel makes no sense.

Why not just make it a bool then?

I wonder if it might be better to specify configuration via 
/proc/<pid>/attr rather than module parameters.



- James
-- 
James Morris
<jmorris@redhat.com>


