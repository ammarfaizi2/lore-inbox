Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTDWVtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTDWVtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:49:43 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:63911 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263566AbTDWVtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:49:42 -0400
Subject: Re: [Bug 622] New: ALSA Choppy During Thing Like Window Changes
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <21270000.1051112116@[10.10.2.4]>
References: <21270000.1051112116@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1051135300.652.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 24 Apr 2003 00:01:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 17:35, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=622
> Problem Description:
> When there is a short burst of high CPU usage, ALSA tends to skip for up to
> a second. This has always worked fine with 2.4.x OSS.

Uhmm... Maybe a problem with the backboost interactivity enhancements.
Does this happen with command-line apps like mpg123, mpg321, ogg123,
etc? In my case, I've experienced those "sound skips" when using XMMS,
but not mpg123 or ogg123. I think it's both a "corner-case" problem with
the interactivity changes in the 2.5-series scheduler and XMMS itself.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

