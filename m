Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWFRPME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWFRPME (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFRPME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:12:04 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:135 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932231AbWFRPMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:12:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.17-ck1
Date: Mon, 19 Jun 2006 01:11:54 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
References: <200606181736.38768.kernel@kolivas.org> <Pine.LNX.4.61.0606181703380.8787@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606181703380.8787@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606190111.54914.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 01:06, Jan Engelhardt wrote:
> >These are patches designed to improve system responsiveness and
> > interactivity. It is configurable to any workload but the default ck
> > patch is aimed at the desktop and cks is available with more emphasis on
> > serverspace.
>
> Last time (2.6.17-rc6-ck1), I had a strange experience over the regular
> scheduler. When three gccs were competing for time, each of them got a time
> window of 1/3 second in which each ran at 99%.
> The regular scheduler does it in a way so that each time window is as small
> as possible, that is, top shows 33% for each process on low top
> udating intervals like 0.1 sec.
> This behavior was not observed with 2.6.16-rcX-ck.

Were you running them SCHED_IDLEPRIO or in compute mode? They would do that.

-- 
-ck
