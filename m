Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTENUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTENUd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:33:28 -0400
Received: from habariff.stacken.kth.se ([130.237.237.19]:6539 "EHLO
	habariff.pdc.kth.se") by vger.kernel.org with ESMTP id S262850AbTENUdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:33:25 -0400
Date: Wed, 14 May 2003 22:45:05 +0200 (CEST)
Message-Id: <20030514.224505.68282455.haba@pdc.kth.se>
To: jaharkes@cs.cmu.edu
Cc: dhowells@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
From: Harald Barth <haba@pdc.kth.se>
In-Reply-To: <20030514165838.GD20171@delft.aura.cs.cmu.edu>
References: <24225.1052909011@warthog.warthog>
	<20030514165838.GD20171@delft.aura.cs.cmu.edu>
X-Mailer: Mew version 3.0.55 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This was my last mail on the subject as I seem the be the only one on
> that actually seem to view PAGs the way I do.

Jan, that would be a pity because in that case I (or someone else) of
the openafs-devel regulars would have to explain. I think you did a
better job that I would have done. You seem to have the references
handy. I can understand if you are not happy in writing more, because
part of the debate in this thread has been an all time low, rude and
very jumpy from one subject to another without getting anywhere. My
judgment is the one of a regular openafs-devel reader, customs in
other mailing lists may differ.

Asking questions is better that assuming something and waiting to be
proven wrong or right. Splitting up the problem in sub problems is
good, talking about function (the program mechanics) and form (coding
style) at the same time is difficult. Bad language is less convincing
than references.

A PAG is a session identifier (inherited like group membership) which
allows a user to temporarily switch to a new authentication context in
order to perform tasks which require this. The reference mentioned by
Jan explains this and I can add that I and a lot of fellow users use
it in that way on a daily basis. There are other related problems like
credential storage that need to be looked at, but that is not the same
thing as a PAG.

Harald.
