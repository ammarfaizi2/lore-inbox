Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUJGSqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUJGSqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJGSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:45:45 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:60077 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S267772AbUJGSnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:43:45 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
References: <200410071318.21091.mbuesch@freenet.de>
	<20041007151518.GA14614@logos.cnet>
	<200410071917.40896.mbuesch@freenet.de>
	<20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp>
	<20041007164221.GD14614@logos.cnet>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Thu, 07 Oct 2004 20:43:39 +0200
Message-ID: <x63c0qbc84@gzp>
User-Agent: Gnus/5.110003 (No Gnus v0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo.tosatti@cyclades.com>:

| > There is really no way to run 2.4 without swap?
| 
| Nope. Any kernel can't. The thing is the system overcommits 
| memory (it allows applications to allocate more memory than the system 
| is able to handle).

Okay, then whats the required minimum swap size that needed to avoid
such crashes?

In the case when the system is in the ram, quite funny to allocate a
swap file on the ramdisk anyway...
