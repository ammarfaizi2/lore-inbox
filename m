Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbTCLQCc>; Wed, 12 Mar 2003 11:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCLQCc>; Wed, 12 Mar 2003 11:02:32 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:517 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261750AbTCLQCb>; Wed, 12 Mar 2003 11:02:31 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303121614.h2CGEJA5001090@81-2-122-30.bradfords.org.uk>
Subject: Re: bio too big device
To: axboe@suse.de (Jens Axboe)
Date: Wed, 12 Mar 2003 16:14:19 +0000 (GMT)
Cc: aebr@win.tue.nl, andre@linux-ide.org, scott-kernel@thomasons.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030312155105.GJ834@suse.de> from "Jens Axboe" at Mar 12, 2003 04:51:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am not quite sure I understand your reasoning.
> > We have seen *zero* drives that do not understand 256 sector commands.
> > Maybe such drives exist, but so far there is zero evidence.
> 
> Have you read the thread? You are obviously mistaken.

I've read most of it, and as far as I can see the problem is that one
drive is known to accept 256 sector commands and occasionally fail on
them.  Since that is obviously broken behavior, I don't see how it can
possibly even be suggested that we reduce the performance of possibly
every other hard disk in use[1] just to compensate for it.

[1] Note that the known broken disk is 700 MB one, so there probably
aren't many in use anyway.

John.
