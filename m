Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUFASe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUFASe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUFASe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 14:34:59 -0400
Received: from outmx022.isp.belgacom.be ([195.238.2.203]:10663 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265115AbUFASe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 14:34:58 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Message-Id: <1086114982.2278.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Jun 2004 20:36:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 01:30, Bernd Eckenfels wrote:
> In article <40BBB5F7.1010407@yahoo.com.au> you wrote:
> > Well, at the "expense" of paging out unused memory. I don't see
> > any swapin.
> 
> On a slow system with small memory you quite often see swapped out
> applications like for example a kopete messenger windows. Once you click on
> it, it takes 10sec or more to get responsive again. Of course its a slow
> system, but gradually paging out and forgetting image pages has that effecct
> on faster systems too, makes the desktop sluggish.
I guess we have a design problem right here.We could add per-process
swappiness attribute.That swap thread becomes boring coz we're looking
globally what's going wrong locally.

FabF


