Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUDSA4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUDSA4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:56:55 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:12960 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S263840AbUDSA4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:56:54 -0400
Date: Mon, 19 Apr 2004 02:56:51 +0200
To: linux-kernel@vger.kernel.org
Subject: CFQ iosched praise: good perfomance and better latency
Message-ID: <20040419005651.GA7860@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been trying CFQ ioscheduler in my software raid5 with nice results,
I've observed that a latency pattern still exists, just as in the
anticipatory ioscheduler, but those spikes are now much lower (from
6ms with AS to 2ms with CFQ as seen in the bottom of
http://pedro.larroy.com/devel/iolat/analisys/),
plus apps seems to get a fair amount of io so they don't get starved.

Seems a good choice for io loaded boxes. Thanks Jens Axboe.

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
