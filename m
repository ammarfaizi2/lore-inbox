Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbTLHBMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 20:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLHBMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 20:12:03 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:52180 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S265150AbTLHBMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 20:12:01 -0500
Date: Mon, 8 Dec 2003 02:11:54 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 - fork, dup, dup2 oddities
Message-ID: <20031208011154.GK13201@mail.muni.cz>
References: <20031207210305.GE13201@mail.muni.cz> <20031208004655.GA23644@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031208004655.GA23644@kroah.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 04:46:55PM -0800, Greg KH wrote:
> The ttyUSB* nodes right now have a bug that prevents more than one
> open() to work properly.  Well actually, the bug is on the close()
> part...
> 
> Anyway, can you try the patch I posted here yesterday?  A copy of it is
> below.  It should fix this bug.  Please let me know either way.

Thanks, this patch works for me. pppd now correctly connect via ttyUSB. 

However similar patch will be need for ircomm-tty. That is not functional as
well.

-- 
Luká¹ Hejtmánek
