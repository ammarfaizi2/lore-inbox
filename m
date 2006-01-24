Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWAXChY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWAXChY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWAXChY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:37:24 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:54170 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030213AbWAXChX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:37:23 -0500
Date: Tue, 24 Jan 2006 03:33:58 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060124023357.GA4064@wohnheim.fh-wedel.de>
References: <43D3295E.8040702@comcast.net> <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr> <20060122190533.GH10003@stusta.de> <1137956898.3328.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1137956898.3328.38.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 January 2006 20:08:17 +0100, Arjan van de Ven wrote:
> 
> it stands for "logging" since jffs2 at least is NOT a journalling
> filesystem.... but a logging one. I assume jffs is too.

s/logging/log-structured/

People could (and did) argue that jffs[|2] is a journalling
filesystem consisting of a journal and _no_ regular storage.  Which is
quite sane.  Having a live-fast, die-young journal confined to a small
portion of the device would kill it quickly, no doubt.

Jörn

-- 
Das Aufregende am Schreiben ist es, eine Ordnung zu schaffen, wo
vorher keine existiert hat.
-- Doris Lessing
