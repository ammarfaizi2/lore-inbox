Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTE1VUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTE1VUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:20:31 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:11138 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261158AbTE1VUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:20:30 -0400
Date: Wed, 28 May 2003 23:33:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'fscope': a new debugging tool
Message-ID: <20030528213333.GA667@elf.ucw.cz>
References: <20030526230956.65746.qmail@web41504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526230956.65746.qmail@web41504.mail.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> QUESTIONS
> 
> 0) The fields go from innermost frame to outermost frame.
> The last field is the outermost. So read them backwards,
> until the last field repeats - there's your cycle.
> 
> 1) These are merely _potentially_ dangerous cycles in the
> code - so what is a good heuristic to decide which ones
> to investigate?
> 
> 2) Why in this case are there 12 times as many instances
> found for the ACPI stuff as for the rest of the kernel?
> Is ACPI a can of worms or what?

Yes it is can of worms.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
