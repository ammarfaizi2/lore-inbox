Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWDKUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWDKUyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWDKUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:54:45 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:62661 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S1750941AbWDKUyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:54:44 -0400
Message-ID: <443C178B.3030805@psc.edu>
Date: Tue, 11 Apr 2006 16:54:35 -0400
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
References: <443C03E6.7080202@gentoo.org> <443C024C.2070107@psc.edu> <443C0B74.50305@gentoo.org> <443C09A7.2040900@psc.edu> <443C1738.20605@gentoo.org>
In-Reply-To: <443C1738.20605@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is almost certainly due to a buggy firewall that doesn't understand 
TCP window scaling.  I've usually seen this in the past with OpenBSD 
firewalls.  Do you have one of these in your path?

Thanks,
   -John
