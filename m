Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVJPVOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJPVOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 17:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJPVOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 17:14:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:36956 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751205AbVJPVOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 17:14:44 -0400
Date: Sun, 16 Oct 2005 23:15:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mark Rustad <MRustad@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc4] kbuild: once again use Makefiles in obj tree
Message-ID: <20051016211517.GA26616@mars.ravnborg.org>
References: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com> <r02010500-1042-1784C9C83CBE11DA99900011248907EC@[10.64.61.29]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r02010500-1042-1784C9C83CBE11DA99900011248907EC@[10.64.61.29]>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 09:23:28AM -0500, Mark Rustad wrote:
> I believe that I have found and fixed the problem that I encountered earlier this week
> with Makefiles not being used from the objects tree as they had been in every 2.6 kernel
> I have worked with since 2.6.5. I I view this as a regression in 2.6.14-rc4. I believe
> that the following patch fixes it.

Hi Mark.
kbuild will not guarantee you way of working in all cases. Therefore no
special implementation will be accepted to try to support it for
specific files.

The changes you point out that breaks your working methodology was added
to fix broken support for external modules.

	Sam
