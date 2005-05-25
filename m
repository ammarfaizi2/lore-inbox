Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVEYA7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVEYA7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVEYA7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:59:54 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61607 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262219AbVEYA7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:59:48 -0400
To: jgarzik@pobox.com, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [OT] pull request notation
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 24 May 2005 17:59:46 -0700
Message-ID: <7vll64rugt.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> Please pull the 'new-ids' branch from
JG>
JG> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
JG>
JG> This add...

I am not a kernel developer, but I think the way this particular
pull request is worded can be made much more friendly to Cogito
users (that probably is the rest of the world except you, me and
Linus ;-).  They use URL fragment notation to express the branch
head, like this:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git#new-ids

At least for me, eyes always skip to the "rsync://..." part
immediately after seeing "Please pull.." part.

For Linus I am willing to volunteer updating git-pull-script to
take the same URL fragment notation, but as Jeff correctly
pointed out it already takes the "branch" name as its second
parameter so it probably would not be necessary.

