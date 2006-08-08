Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWHHPAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWHHPAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWHHPAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:00:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9654 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932603AbWHHPA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:00:28 -0400
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical
	attributes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Pavel Machek <pavel@suse.cz>,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492543835-git-send-email-multinymous@gmail.com>
	 <20060807140721.GH4032@ucw.cz>
	 <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
	 <20060807182047.GC26224@atjola.homenet>
	 <20060808122234.GD5497@rhun.haifa.ibm.com> <20060808125652.GA5284@ucw.cz>
	 <20060808131724.GE5497@rhun.haifa.ibm.com>
	 <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
	 <20060808134337.GF5497@rhun.haifa.ibm.com>
	 <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 16:19:40 +0100
Message-Id: <1155050380.5729.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the concern is just the naming then change it to end _trylock, that
fits the locking primitives we use for the kernel in general, but its
really just polishing work

