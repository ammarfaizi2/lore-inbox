Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVK2G2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVK2G2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVK2G2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:28:22 -0500
Received: from smtp.ispwest.com ([216.52.245.18]:10764 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1751257AbVK2G2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:28:21 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <d0d8bf3880744a79a8a5c26c8459e9ac.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: Re: [PATCH] Resetting packet statistics
Date: Mon, 28 Nov 2005 22:28:18 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller
Sent: 11/28/2005 10:12:38 PM
> You can't change existing behavior in order to get the new behavior
> you want.  Some applications might be depending upon what happens
> currently.

Is there a way to work around this? It seems to me this is a better way of doing it
because it doesn't require extra variables on the user's end and the stats are only
changed if you explicitly ask for it. Do you agree with that?

Kris

