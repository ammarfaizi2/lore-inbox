Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTGURYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270664AbTGURYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:24:55 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:25357 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270663AbTGURYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:24:22 -0400
Date: Mon, 21 Jul 2003 18:39:23 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: "Sam (Uli) Freed" <sam@freed.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 does locks up VGA and keyboard
In-Reply-To: <3F1C21C3.4000901@freed.net>
Message-ID: <Pine.LNX.4.44.0307211837460.10689-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. CONFIG_INPUT is modular. This is bad and turns off CONFIG_VT. Please 
set this to yes. Then turn on CONFIG_VT. After you can go into the Video 
menu and select what ever console driver you like. Also be careful. You 
have your keyboard modular as well and this would make typing difficult.


