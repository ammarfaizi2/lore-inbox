Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTKUAFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264171AbTKUAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:05:34 -0500
Received: from gprs147-68.eurotel.cz ([160.218.147.68]:18561 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264133AbTKUAF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:05:28 -0500
Date: Fri, 21 Nov 2003 01:06:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaheed <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031121000604.GA580@elf.ucw.cz>
References: <200311201726.48097.srhaque@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311201726.48097.srhaque@iee.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > B) A heuristic that looks at the mounted block devices for things that smell 
> > like a resume partition would actually be more robust in that case.
> 
> How about a static signature followed by a timestamp? That way, maybe we could 
> have a resume menu like this:
> 
> /dev/hda3  (kernel 2.7.88, suspended on 01-04-2004 20:00:00)
> /dev/hda4  (kernel 2.8.99, suspended on 31-05-2005 20:00:00) ***
> Resume in 5..4..3..2..1..
> 
> with a 5 second countdown before it chooses the most recent? Or in Pavel's 
> examples:
> 
> Erk! Nowhere to resume from! 

If you select hda3 at this point, bye bye your data.

									Pavel
PS: And I mean it. This is not just your average "few more files in
lost+found" kind of corruption.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
