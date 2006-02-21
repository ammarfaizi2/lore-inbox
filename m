Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWBUELK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWBUELK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161316AbWBUELK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:11:10 -0500
Received: from smtp.enter.net ([216.193.128.24]:50693 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161309AbWBUELI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:11:08 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 20 Feb 2006 23:11:28 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, nix@esperi.org.uk, mj@ucw.cz,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, chris@gnome-de.org,
       axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <200602192053.25767.dhazelton@enter.net> <43F9F11E.nail5BM21M01Q@burner>
In-Reply-To: <43F9F11E.nail5BM21M01Q@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202311.29759.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg, I've been thinking about your report about Linux munging CDB's sent to 
certian ATAPI devices. While reading the MMC-5 spec again today (my memory of 
it was starting to fail and I felt I had best be on top of it in this 
discussion) a statement made about sending SCSI commands to ATAPI devices 
caught me.

ATAPI command packets are fixed at a 12 byte size. Is it possible you tried to 
send a CDB in excess of that fixed size re: those drives that get a munged 
CDB?

Just a thought...

DRH
