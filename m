Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUKWXM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUKWXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUKWXKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:10:08 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:43443 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261620AbUKWXIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:08:45 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Subject: Re: 2.6.9 page allocation failure
Date: Wed, 24 Nov 2004 00:08:28 +0100
User-Agent: KMail/1.6.2
References: <2E314DE03538984BA5634F12115B3A4E01BC40DC@email1.mitretek.org>
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC40DC@email1.mitretek.org>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411240008.31940.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 14:39, you wrote:
> This is a known problem with the Intel Gigabit NIC and possibly other
> NIC's dealing with TSO (tcp segmentation offload).
>
> Either try turning it off (with ethtool) or wait until 2.6.10 is
> released or try the latest -mm tree as Andrew Morton is working on
> fixing this issue.
>
> This problem began with 2.6.9 and has been reported on the list quite a
> few times now :)

We have seen those memory allocation failures already with 2.6.7, crashing our 
server every morning on doing its cron daily cron jobs, so this is certainly 
not only an issue since 2.6.9. Unfortunately that time nobody seemed to be 
interested in my bugreports... Finally we had to switch back to 2.4.27, 
though it is much slower as fileserver.


Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
