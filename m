Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937386AbWLEGsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937386AbWLEGsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937424AbWLEGsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:48:36 -0500
Received: from mout2.freenet.de ([194.97.50.155]:57790 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937386AbWLEGsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:48:35 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt1, yum/rpm
Date: Tue, 5 Dec 2006 07:48:50 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061130083358.GA351@elte.hu> <200612050119.59113.fzu@wemgehoertderstaat.de>
In-Reply-To: <200612050119.59113.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612050748.50553.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Dezember 2006 01:19 schrieb Karsten Wiese:
> Am Donnerstag, 30. November 2006 09:33 schrieb Ingo Molnar:
> > i have released the 2.6.19-rt1 tree, which can be downloaded from the
> 
> Hi Ingo,
> 
> here comes a freerunning trace explaining the weirdness I see here.
> I tried max_latency tracing first, didn't see anything usefull,
> went on with tracing freerunning with a user_trace_stop() at the spot,
> where snd-usb-usx2y diagnoses hickup.

Seams to hickup when irq happens while uhci_hcd is busy doing some
kind of timer triggered housekeeping.
Will look into uhci code deeper ;-)

      Karsten
