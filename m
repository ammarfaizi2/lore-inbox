Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTFWMMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265485AbTFWMMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:12:10 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:40102 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265479AbTFWMMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:12:07 -0400
Date: Mon, 23 Jun 2003 14:26:00 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] emu10k1 module in 2.5.72 oopses when being removed
Message-ID: <20030623142600.B594@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	linux-kernel@vger.kernel.org
References: <20030622120046.A21264@ss1000.ms.mff.cuni.cz> <Pine.LNX.4.53.0306220950210.12131@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0306220950210.12131@montezuma.mastecende.com>; from zwane@linuxpower.ca on Sun, Jun 22, 2003 at 09:55:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Code:  Bad EIP value.
> 
> It appears the module got unloaded prematurely, is this the only modular 
> PCI driver you have?

Yes, it is. I tried id with no other modules loaded (not counting soundcore and
ac97_codec) and the exact same OOPS happens again.

Any ideas/patches?

Rudo.
