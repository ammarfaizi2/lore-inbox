Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVILMqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVILMqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVILMqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:46:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:18601 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750789AbVILMp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:45:59 -0400
Subject: Re: Oops 2.6.13-git6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050912102011.GA2379@mail.muni.cz>
References: <20050912102011.GA2379@mail.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 14:11:10 +0100
Message-Id: <1126530670.30449.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-12 at 12:20 +0200, Lukas Hejtmanek wrote:
> Is there some way how to change battery and cdrom without reboot?

The 2.6 IDE layer doesn't support IDE drive hot or warm plug. 2.4-ac did
but that was the only one that ever supported it.

Nevertheless it should not have crashed only errored so the bug report
is useful 8)

