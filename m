Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUJETx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUJETx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUJETuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:50:37 -0400
Received: from peabody.ximian.com ([130.57.169.10]:224 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265800AbUJETq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:46:59 -0400
Subject: Re: /dev/misc/inotify 0.11
From: Robert Love <rml@novell.com>
To: David Busby <DBusby@SeattleMortgage.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <82C88232E64C7340BF749593380762021166F3@seattleexchange.SMC.LOCAL>
References: <82C88232E64C7340BF749593380762021166F3@seattleexchange.SMC.LOCAL>
Content-Type: text/plain
Date: Tue, 05 Oct 2004 15:45:24 -0400
Message-Id: <1097005524.4429.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 09:55 -0700, David Busby wrote:

In the future please CC me and John McCutchan <ttb@tentacle.dhs.org> on
inotify bugs if you can.  Or respond to an existing inotify thread.  I
almost missed this.  Thanks.

> 1> When I say `cat /dev/misc/inotify' my machine stops responding
> instantly.  I've not had a chance to see what happens.  I know I'll not
> normally say that but when I say something else dumb like cat
> /dev/misc/rtc cat will simply wait, not choke up my whole system.

I cannot reproduce this.

`cat /dev/inotify` simply blocks in inotify_read().

You use devfs?  Can you try it without that?

	Robert Love


