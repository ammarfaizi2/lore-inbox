Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbUDUSuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUDUSuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUDUSuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:50:25 -0400
Received: from relay02s.ntr.oleane.net ([194.2.8.83]:63189 "EHLO
	relay02s.ntr.oleane.net") by vger.kernel.org with ESMTP
	id S263605AbUDUSuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:50:21 -0400
Date: Wed, 21 Apr 2004 20:50:35 +0200 (CEST)
From: Marc Herbert <marc.herbert@free.fr>
X-X-Sender: mherbert@fcat
To: linux-kernel@vger.kernel.org
Subject: directory "net/core" ignored by bitkeeper :-/
Message-ID: <Pine.LNX.4.58.0404212041580.18088@fcat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try this in the official 2.4 tree:

touch net/ipv4/foo.c
touch net/core/bar.c
bk extras

=>   net/ipv4/foo.c
                     !!!



I am not a bitkeeper wizard, so I can only suggest removing "core"
from Bitkeeper/etc/ignore (as opposed to renaming "net/core" :-D)

Do many people have "core" files in their developments tree? So often
it becomes a major inconvenience? ("major" = more than ignoring
net/core)


Cheers,

Marc.

PS: I am not subscribed to the list. Keep me in Cc: if needed.
