Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUEJVKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUEJVKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUEJVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:10:39 -0400
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:26318 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S261724AbUEJVKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:10:34 -0400
Subject: Re: usb_hcd_irq, nobody cared on 2.6.6
From: Stian Jordet <liste@jordet.nu>
To: Thomas Cataldo <tomc@compaqnet.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1084222439.3548.7.camel@buffy>
References: <1084222439.3548.7.camel@buffy>
Content-Type: text/plain
Message-Id: <1084223427.2369.2.camel@chevrolet.jordet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Mon, 10 May 2004 23:10:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 10.05.2004 kl. 22.53 +0200, skrev Thomas Cataldo:
> Hi,
> 
> Few minutes after boot I found that in my logs :
> 
> irq 10: nobody cared!
[snip]
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)

This is a problem with all Apollo Pro 133/266/MVP3 it seems. Check
http://bugzilla.kernel.org/show_bug.cgi?id=2243 and see if you have the
same symptoms.

Best regards,
Stian

