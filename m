Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVFWTpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVFWTpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbVFWTkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:40:08 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:9992 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262705AbVFWTdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:33:09 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 23 Jun 2005 15:32:25 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic79xx -> can't  suspend
Message-ID: <20050623193224.GD2251@voodoo>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1119549104.13259.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119549104.13259.1.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/05 01:51:43PM -0400, Lee Revell wrote:
> I have a machine with an Adaptec 2940U2W adapter running 2.6.11.  When I
> try to go into standby like so:
> 
>     echo standby > /sys/power/state
> 
> this is what happens:

AFAIK no SCSI drivers have had power management functions implemented, a
quick grep for PM_ in drivers/scsi seems to confirm that only the PCMCIA
SCSI drivers even look for PM events.

> 
> Lee
>

Jim.
