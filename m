Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVBORKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVBORKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBORIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:08:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55345 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261799AbVBORFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:05:45 -0500
To: "xerces8" <xerces8@butn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dummy vt for XFree86 ?
X-Message-Flag: Warning: May contain useful information
References: <WorldClient-F200502151033.AA33440074@butn.net>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 15 Feb 2005 09:05:37 -0800
In-Reply-To: <WorldClient-F200502151033.AA33440074@butn.net> (xerces8@butn.net's
 message of "Tue, 15 Feb 2005 10:33:44 +0100")
Message-ID: <52y8dpycri.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Feb 2005 17:05:37.0865 (UTC) FILETIME=[92264390:01C51380]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    xerces8> Hi!  Is there a way to prevent VT switching for XFree86 ?

    xerces8> I have two gfx cards and want to start an X server on the
    xerces8> secondary card, while leaving the VTs on the primary card
    xerces8> active.

Take a look at the novtswitch and sharevts patches for X.org (I
believe Ubuntu Hoary ships with these, and they may actually be in the
X.org mainline CVS already).  Do these do what you want?

 - R.
