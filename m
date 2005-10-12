Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVJLAJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVJLAJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVJLAJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:09:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3999 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932353AbVJLAJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:09:41 -0400
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a
	terminating (PF_EXITING) process.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F36B115@mtk-sms-mail01.digi.com>
References: <335DD0B75189FB428E5C32680089FB9F36B115@mtk-sms-mail01.digi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 01:38:25 +0100
Message-Id: <1129077506.23677.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-11 at 14:35 -0500, Kilau, Scott wrote:
> Also, why did this work under 2.4?
> 
> This is why I was wondering if this was intentional, or was just an
> oversight...

It seems that the signal reception in exiting process logic has changed.
Serial depends on the old behaviour and its difficult to see how it
should be fixed and what else would be "correct behaviour" here.

Alan

