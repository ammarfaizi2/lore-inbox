Return-Path: <linux-kernel-owner+w=401wt.eu-S1755390AbXABR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbXABR0g (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXABR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:26:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:35182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbXABR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:26:35 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: x86 instability with 2.6.1{8,9}
Date: Tue, 2 Jan 2007 12:25:57 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070101160158.GA26547@deepthought>
In-Reply-To: <20070101160158.GA26547@deepthought>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021225.57708.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it's been nothing but trouble in 32-bit mode.
> It still works fine when I boot it in 64-bit mode. 

A shot in the dark at the spontaneous reset issue, but no clue on the 32 vs 64-bit observation...

See if ACPI exports any temperature readings under /proc/acpi/thermal_zone/*/temperature
and if so, keep an eye on them to see if there is an indication of a thermal problem.

( And if ACPI doesn't, maybe lmsensors can find something.)

cheers,
-Len
