Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUDXGjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUDXGjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 02:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDXGjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 02:39:54 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:14310 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261943AbUDXGjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 02:39:53 -0400
Subject: forged email senders (was: InterScan NT Alert)
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <S261830AbUDXCIF/20040424020805Z+43@vger.kernel.org>
References: <S261830AbUDXCIF/20040424020805Z+43@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082788785.8985.2.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Sat, 24 Apr 2004 08:39:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Sender, InterScan has detected virus(es) in your e-mail attachment.

What about adding an SPF entry to the vger.kernel.org DNS?

vger IN TXT "v=spf1 mx ~all"

or something. This is a hint for SPF parsers (like the upcoming
SpamAssassin) that mails from vger.kernel.org that are not sent via the
MX server might be forged.


