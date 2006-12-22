Return-Path: <linux-kernel-owner+w=401wt.eu-S1945899AbWLVCBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945899AbWLVCBA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 21:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945912AbWLVCA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 21:00:59 -0500
Received: from gw.goop.org ([64.81.55.164]:54525 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945899AbWLVCA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 21:00:59 -0500
Message-ID: <458B3C51.4030905@goop.org>
Date: Thu, 21 Dec 2006 18:00:49 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug> <458ADEDD.8010903@goop.org> <20061221215942.GC18827@slug>
In-Reply-To: <20061221215942.GC18827@slug>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> This is a -mm1 kernel + your efl_offset fix + the attached patch.
> So the problem came from putreg still saving %gs to the stack where
> there's no slot for it, whereas getreg got things right.
>   

That patch looks good, but I think it is already effectively in Andrew's
queue, because I noticed some problems in there when I reviewed  the
convert-to-%fs patch.

    J
