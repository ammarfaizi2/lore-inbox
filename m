Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbSKSToL>; Tue, 19 Nov 2002 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKSToL>; Tue, 19 Nov 2002 14:44:11 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44676 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267150AbSKSToI>; Tue, 19 Nov 2002 14:44:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 11:51:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Grant Taylor <gtaylor+lkml_cfaea111902@picante.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <200211191933.gAJJXumU025156@habanero.picante.com>
Message-ID: <Pine.LNX.4.44.0211191149220.1918-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Grant Taylor wrote:

> If we're bound to poll small sets of epoll fds perhaps a bit of
> improvement in poll would be worthwhile.  I should go look at my

The current poll() with a number of fds you're talking about, scales
beautifully.



- Davide


