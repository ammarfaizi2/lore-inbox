Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbUK3Niy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbUK3Niy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUK3Niy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:38:54 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:33991 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262066AbUK3Nix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:38:53 -0500
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 49/51: Checksumming
In-Reply-To: <20041130130227.GA4670@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300589.5805.392.camel@desktop.cunninghams> <200411290455.10318.rob@landley.net> <200411290455.10318.rob@landley.net> <20041130130227.GA4670@openzaurus.ucw.cz>
Date: Tue, 30 Nov 2004 13:38:52 +0000
Message-Id: <E1CZ8DU-0005n5-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> Yes, it would be good sanity check. ext3 replays journals even on
> read-only mount so your / will need to be ext2...

The alternative is to have a userspace application that can check these
things without having to replay the log.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
