Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271822AbTG2QUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270255AbTG2QUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:20:25 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:42462
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S271895AbTG2QUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:20:08 -0400
Date: Tue, 29 Jul 2003 18:21:38 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: s.rivoir@gts.it
Subject: Re: Disk performance degradation
Message-Id: <20030729182138.76ff2d96.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-07-29 12:00:06 Stefano Rivoir wrote:

> Is there something I'm missing?!

No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
512". See thread for explanation (it's the borked value for readahead):

http://marc.theaimsgroup.com/?l=linux-kernel&m=105830624016066&w=2

Mvh
Mats Johannnesson
