Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVGNQIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVGNQIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNQIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:08:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:32652 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263049AbVGNQID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:08:03 -0400
Subject: Re: pci_size() error condition
From: John Rose <johnrose@austin.ibm.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714034019.B25768@jurassic.park.msu.ru>
References: <20050714034019.B25768@jurassic.park.msu.ru>
Content-Type: text/plain
Message-Id: <1121357040.9265.1.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Jul 2005 11:04:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was always effectual for IO where the mask is 0xffff.

Okay, point taken :)  So for cases of base == maxbase, why would we ever
want to return a nonzero value?  What is the intended purpose of the
second part of that conditional?

