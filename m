Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbTLFUYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbTLFUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:24:43 -0500
Received: from smtp14.eresmas.com ([62.81.235.114]:59288 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S265242AbTLFUYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:24:42 -0500
Message-ID: <3FD23AD2.5090804@wanadoo.es>
Date: Sat, 06 Dec 2003 21:23:46 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re old oom-vm for 2.4.32 (was oom killer in 2.4.23)
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Bergmann wrote:

> If anyone  is interested:
> Norbert Federa sent me this link for a "quick&dirty" patch he made
> for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including the
> old oom-killer  - without guarantee but it does work very well for me ...
> 
> http://www.esesix.at/kernel/vm-2.4.22.diff
> http://www.esesix.at/kernel/vm-2.4.22.diff.gz

Tvrtko A. Ursulin <tvrtko.ursulin@zg.htnet.hr> wrote a patch for .22
to do a modular oom_killer and it also adds two new killers:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106631029726307&w=2

alternatively you can try .23-aa, it has some patches that are missing in .23

