Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbUK0CX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbUK0CX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUK0CTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:19:47 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:9928 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263138AbUK0CTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 21:19:21 -0500
To: ncunningham@linuxmail.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
In-Reply-To: <1101427035.27250.161.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298112.5805.330.camel@desktop.cunninghams> <20041125233243.GB2909@elf.ucw.cz> <20041125233243.GB2909@elf.ucw.cz> <1101427035.27250.161.camel@desktop.cunninghams>
Date: Sat, 27 Nov 2004 02:19:15 +0000
Message-Id: <E1CXsB9-00022M-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> You want your cake and to eat it too? :> We don't want to warn the user
> before they shoot themselves in the foot, but not loudly enough that
> they can't help notice and choose to do something before the damage is
> done?

We have userspace to do this, surely? Make the standard method of
triggering resume involve an initrd, and have a small application that
does sanity checks before the resume. In case of failure, have it prompt
the user. As long as it doesn't do bad things to the filesystem,
there's no danger. There's no reason to do this in the kernel.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
