Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWHHMtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWHHMtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWHHMtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:49:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33799 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964858AbWHHMtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:49:46 -0400
Date: Tue, 8 Aug 2006 12:46:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 11/12] hdaps: Stop polling timer when suspended
Message-ID: <20060808124655.GI4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849307861-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154849307861-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch stops the hdaps driver's polling timer when the module is 
> suspended. Accessing a shut-down accelerometer is not harmful, but 
> let's avoid it anyway.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Looks ok.

Signed-off-by: Pavel Machek <pavel@suse.cz>

-- 
Thanks for all the (sleeping) penguins.
