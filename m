Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264341AbRFLMHk>; Tue, 12 Jun 2001 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264346AbRFLMHa>; Tue, 12 Jun 2001 08:07:30 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:28151 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264341AbRFLMH2>; Tue, 12 Jun 2001 08:07:28 -0400
Message-Id: <l03130300b74b9ddb0369@[192.168.239.105]>
In-Reply-To: <20010611223357.A959@bug.ucw.cz>
In-Reply-To: <20010611113604.4073.qmail@web3504.mail.yahoo .com>; from 
 =?iso-8859-1?Q?Mich=E8l?= Alexandre Salim on Mon, Jun  11, 2001 at 
 12:36:04PM +0100 <20010611113604.4073.qmail@web3504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Jun 2001 11:26:32 +0100
To: Pavel Machek <pavel@suse.cz>,
        =?iso-8859-1?Q?Mich=E8l?= Alexandre Salim 
	<salimma1@yahoo.co.uk>,
        linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Clock drift on Transmeta Crusoe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> clock drift of a few minutes per day.

That's about 0.1%.  It may be relatively large compared to tolerances of
hardware clocks, but it's realistically tiny.  It certainly compares
favourably with mkLinux on my PowerBook 5300, which usually drifts by
several hours per day regardless of actual load.

The drift might be caused by something masking interrupts for too long, too
often, considering you state that the hardware clock remains comparatively
well-synced.  As another poster suggests, the framebuffer may be to blame.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


