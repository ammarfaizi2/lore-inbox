Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJXI04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 04:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTJXI04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 04:26:56 -0400
Received: from smtp13.eresmas.com ([62.81.235.113]:25310 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S262069AbTJXI0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 04:26:51 -0400
Message-ID: <3F989C0B.9040309@wanadoo.es>
Date: Fri, 24 Oct 2003 05:27:07 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [patch] 2.4.23-pre8: link error with both megaraid drivers
References: <3F97F35D.30101@wanadoo.es> <20031023195223.GI11807@fs.tum.de>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> On Thu, Oct 23, 2003 at 05:27:25PM +0200, Xose Vazquez Perez wrote:

>> IMO this patch makes a better job. It only allows one in kernel,
>> and it allows two modules at same time.

> My patch allows this, too, or what did I miss?

Nothing. But your patch adds too much complex code to do a single thing ;-)

> The difference between your and my patch is that your patch doesn't 
> allow one in kernel plus the other one modular.

Yes. And IMO there is not need to build a module when you get
the other statically inside the kernel. I can not imagine what will happen
if one is statically inside the kernel and someone try to load a module :-)

--
HTML mails are going to trash automatically

