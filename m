Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWDZVB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWDZVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWDZVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:01:27 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:36284 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932205AbWDZVB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:01:26 -0400
Date: Wed, 26 Apr 2006 23:01:24 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Message-ID: <20060426210124.GA15619@uio.no>
References: <20060422221232.GA6269@uio.no> <200604261740.47107.Rafal.Wysocki@fuw.edu.pl> <20060426161214.GA13689@uio.no> <200604262259.39691.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200604262259.39691.rjw@sisk.pl>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:59:39PM +0200, Rafael J. Wysocki wrote:
> This kind of agrees with my result ie. list_del() in isolate_lru_pages():

Well, look at the followup -- I'm not convinced the address lookup is right.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
