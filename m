Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUITKM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUITKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUITKM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:12:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:64454 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266189AbUITKM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:12:56 -0400
To: Olaf Hering <olh@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
	<20040920094602.GA24466@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Are we live or on tape?
Date: Mon, 20 Sep 2004 12:12:02 +0200
In-Reply-To: <20040920094602.GA24466@suse.de> (Olaf Hering's message of
 "Mon, 20 Sep 2004 11:46:02 +0200")
Message-ID: <jeoek1xn9p.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

> - fix all broken apps that still rely on mtab. like GNU df(1)

df does not rely on /etc/mtab.  It relies on getmntent.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
