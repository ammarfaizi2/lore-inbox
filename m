Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUBZLJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUBZLJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:09:25 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:3982 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262773AbUBZLJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:09:23 -0500
Subject: Re: [PATCH 2/2] fix in-place de/encryption bug with highmem
From: Christophe Saout <christophe@saout.de>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, jlcooke@certainkey.com,
       linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <Xine.LNX.4.44.0402252311030.4922-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402252311030.4922-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1077793429.6428.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 12:03:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 26.02.2004 schrieb James Morris um 05:13:

> Have you verified that the data corruption bug you saw has been fixed?
> (Just in case there's more to it).

Yes, it's fixed. I've got a collection of tests scripts here to verify
the data integrity. They are able to trigger all kinds of bugs (assuming
there is a bug of course).


