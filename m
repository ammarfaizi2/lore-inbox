Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTAXWfD>; Fri, 24 Jan 2003 17:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAXWfD>; Fri, 24 Jan 2003 17:35:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15597 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261371AbTAXWfC>;
	Fri, 24 Jan 2003 17:35:02 -0500
Date: Fri, 24 Jan 2003 14:32:52 -0800 (PST)
Message-Id: <20030124.143252.97527503.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: Jeff.Wiedemeier@hp.com, jgarzik@pobox.com, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030125014102.A825@localhost.park.msu.ru>
References: <20030124163341.A4366@dsnt25.mro.cpqcorp.net>
	<20030124.133434.66251483.davem@redhat.com>
	<20030125014102.A825@localhost.park.msu.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Sat, 25 Jan 2003 01:41:02 +0300
   
   I don't understand the issue, really. The config register says:
   "MSIs are enabled". Which means: "My platform is *really* going to
   use MSI". Why do you want to ignore that?

I see, why not code up a generic pci_using_msi(pdev) that
does this?

I suggested a per-arch version because I was not clear on how
this exactly worked.
