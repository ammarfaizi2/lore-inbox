Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUEJR1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUEJR1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUEJR1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:27:32 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:3017 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264538AbUEJR1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:27:31 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0405101317180.669-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0405101317180.669-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1084210037.9639.31.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 19:27:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> Better not test it -- I just noticed that without your patch installed the 
> driver would try to dereference a NULL pointer!  Probably the safest 
> approach is to use both patches.

actually I don't see a reason for using both patches, because I can't
follow the point from Oliver that I've assumed a certain order of
disconnect.

However is it the best practice to claim additional interfaces with the
private pointer set to NULL?

Regards

Marcel


