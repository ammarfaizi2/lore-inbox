Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWFSVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWFSVAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWFSVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:00:14 -0400
Received: from main.gmane.org ([80.91.229.2]:58308 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964824AbWFSVAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:00:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marcus Furlong <furlongm@hotmail.com>
Subject: Re: pci bus is hidden behind transparent bridge
Date: Mon, 19 Jun 2006 21:59:24 +0100
Message-ID: <e7737c$fk$1@sea.gmane.org>
References: <e76jsl$558$1@sea.gmane.org>
Reply-To: furlongm@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83-70-234-22.b-ras1.prp.dublin.eircom.net
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Furlong wrote:

> 
> Seems to work fine either way.
> 

Further testing shows it doesn't.

When using pci=assign-busses, the virtual consoles are screwed up (using
vesafb). When the output reaches the bottom of the screen, it just stops,
and the rest of the output isn't visible. Using ctrl-L or switching VT
cleans it up temporarily. It occurs on all VTs and is 100% reproducible
here when booting with the above argument. Everything works fine when
booting without the pci argument.

Marcus.

