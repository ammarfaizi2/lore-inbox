Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTIXQpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbTIXQps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:45:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:29568 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261512AbTIXQps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:45:48 -0400
Date: Wed, 24 Sep 2003 17:45:28 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309241645.h8OGjS9i000412@81-2-122-30.bradfords.org.uk>
To: david.lang@digitalinsight.com, john@grabjohn.com
Subject: Re: Horiffic SPAM
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, rjohnson@analogic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you want to block mail you need to have your MTA return a 500 series
> error code when it gets a connection from that IP address, otherwise the
> sending MTA will just retry later, resulting in the problem described.

Read my post again.

A lot of the simple SMTP engines embedded in viruses _don't_ retry on
4xx error codes.  Real SMTP engines do.

That flaw is what we are taking advantage of, to filter out the junk.

I.E. we tell everybody 'come back later'.  Genuine mail does, whilst
junk mail often doesn't bother.

John.
