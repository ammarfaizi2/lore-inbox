Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVCISgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVCISgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVCISdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:33:15 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:37986 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262217AbVCISax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:30:53 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch 1/1] x86-64: forgot asmlinkage on sys_mmap
Date: Wed, 9 Mar 2005 19:24:00 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, ak@suse.de
References: <20050305190005.0943C4B47@zion> <m1br9swx54.fsf@muc.de>
In-Reply-To: <m1br9swx54.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091924.00518.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 18:24, Andi Kleen wrote:
> blaisorblade@yahoo.it writes:
> > CC: Andi Kleen <ak@suse.de>
> >
> > I think it should be there, please check better.
>
> It doesn't matter. asmlinkage is a nop on x86-64.

Yes, otherwise nothing would work on x86-64 with mmap broken, but for 
cleanness and for the case this change it should be there (otherwise why 
asmlinkage is used in the rest of the file).

And for i386 asmlinkage acquired significance only recently.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

