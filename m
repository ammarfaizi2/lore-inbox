Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTIXRih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTIXRih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:38:37 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:61109 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S261553AbTIXRig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:38:36 -0400
Date: Wed, 24 Sep 2003 18:40:21 +0100 (IST)
From: James Stevenson <james@stev.org>
To: John Bradford <john@grabjohn.com>
cc: david.lang@digitalinsight.com, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>, <rjohnson@analogic.com>
Subject: Re: Horiffic SPAM
In-Reply-To: <200309241645.h8OGjS9i000412@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0309241838360.8056-100000@god.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A lot of the simple SMTP engines embedded in viruses _don't_ retry on
> 4xx error codes.  Real SMTP engines do.
> 
> That flaw is what we are taking advantage of, to filter out the junk.
> 
> I.E. we tell everybody 'come back later'.  Genuine mail does, whilst
> junk mail often doesn't bother.

This also seems to work with most spammer systems.
But its hard to tell which connections to refuse and
which to accept.

I have had a situation where the connection to the
internet has failed on either the mail server or
its backup relay and amount of spam that day for all users
is greatly reduced.

	James

