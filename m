Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbULBVxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbULBVxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULBVxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:53:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261776AbULBVuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:50:19 -0500
Date: Thu, 2 Dec 2004 21:49:32 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
Message-ID: <20041202214932.GE24233@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300802.5805.398.camel@desktop.cunninghams> <20041125235829.GJ2909@elf.ucw.cz> <1101427667.27250.175.camel@desktop.cunninghams> <20041202204042.GD24233@agk.surrey.redhat.com> <1102021461.13302.40.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102021461.13302.40.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 08:04:21AM +1100, Nigel Cunningham wrote:
> It's not internals that need to be exposed.
 
Then why move an internal dm-io structure into a header file and 
  #include "../../drivers/md/dm-io.h"
from another part of the tree?

Alasdair
-- 
agk@redhat.com
