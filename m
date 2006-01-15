Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWAOMHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWAOMHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWAOMHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:07:51 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:22463 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751066AbWAOMHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:07:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=szvFE9T94NJHgq5WDoylfRoycujrGpCyNLvy4oGcs3lgFCRt7SkG6rj5N9pCdnbvpGxmO0YPNkP9zYiA3U3ct27gjJqBf10ENLnlxKJQb2lgNSzmv6l6H9AGEEc3N1TnuEyuxZyiOTptioXBohMjfAQQADt1YK+t7igcGZ+KpEo=
Message-ID: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com>
Date: Sun, 15 Jan 2006 13:07:49 +0100
From: Thomas Fazekas <thomas.fazekas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Modify setterm color palette
Cc: arch@archlinux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the crosspost, I just wasn't sure which group should I target.

Here is what I try to do : I got to modify the standard colors used by setterm,
the reason being my preference for using text consoles rather than xterms.
I also prefer the fg green bg black setup. I can acheave that just by
simply issuing a "setterm -foreground green -store". Now my problem is
that the green I get is too dark on my screeen (even if I set the display
luminosity to max). If I could modify the color used by setterm I
could get a bit
brighter green, but I'm not sure where/how to do that...

I've been looking in the kernel sources in the "console.c" and I think
spotted the
place where the colours are set but it seems to me that a more appropiate
place to do such things would be the terminfo db.

Any hints ?

I'm using radeonfb under Suse/amd64 if that makes any difference...

Rgds
Thomas
