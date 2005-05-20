Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVETO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVETO4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVETO4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:56:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261397AbVETO4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:56:33 -0400
Date: Fri, 20 May 2005 10:56:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kylene Hall <kjhall@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       <sailer@us.ibm.com>, <yoder1@us.ibm.com>, <toml@us.ibm.com>,
       <emilyr@us.ibm.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 1 of 4] ima: related TPM device driver interal kernel
 interface
In-Reply-To: <Pine.LNX.4.62.0505191657210.12334@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0505201048060.20057-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are you using LSM for this?

LSM should be used for comprehensive access control frameworks which 
significantly enhance or even replace existing Unix DAC security.

We're going to end up with a proliferation of arbitrary security features 
lacking an overall architectural view (I've written about this before, 
see http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/0300.html).

I think it would be better to implement this directly.



- James
-- 
James Morris
<jmorris@redhat.com>


