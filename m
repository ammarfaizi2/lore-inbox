Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTEaKkV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTEaKkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:40:21 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:9874 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264270AbTEaKkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:40:20 -0400
Date: Sat, 31 May 2003 12:53:37 +0200 (MEST)
Message-Id: <200305311053.h4VArbVW001936@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: rol@witbe.net
Subject: Re: warning: process 'update' used the obsolete bdflush...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 11:04:20 +0200, Paul Rolland wrote:
>When switching from 2.4.20 to 2.5.x (x being recent), I have this
>message...
>
>What does this mean ?
>1 - I have no process named update running,
>2 - I can't find anything name update in /etc/rc.d/* recursively.

If you have a line with 'update' or 'bdflush' in /etc/inittab,
remove it. (Its obsolete since mid-2.2 or so.)
