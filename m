Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVE3DAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVE3DAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 23:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVE3DAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 23:00:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:31981 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261503AbVE3DAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 23:00:39 -0400
Date: Mon, 30 May 2005 05:00:37 +0200
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RAID-5 design bug (or misfeature)
Message-ID: <20050530030037.GA9022@lina.inka.de>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net> <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 04:47:58AM +0200, Mikulas Patocka wrote:
> But root disk might fail too... This way, the system can't be taken down
> by any single disk crash.

Yes, mirroring has here good properties, must boot loaders work with it, it
is less suspectible to silent corruption and you can use a 1+0 configuration
for additional protection against multi disk failures.

Greetings
Bernd
