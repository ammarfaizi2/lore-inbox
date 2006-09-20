Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWITE3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWITE3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 00:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWITE3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 00:29:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751142AbWITE3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 00:29:23 -0400
Date: Tue, 19 Sep 2006 21:29:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Tony Luck <tony.luck@intel.com>
cc: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
Subject: Re: Efficient Use of the Page Cache with 64 KB Pages
In-Reply-To: <12c511ca0609191555q2bfb934aha4cfc0068c1ccd9a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609192128480.25473@schroedinger.engr.sgi.com>
References: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com> 
 <Pine.LNX.4.64.0609191136580.6460@schroedinger.engr.sgi.com>
 <12c511ca0609191555q2bfb934aha4cfc0068c1ccd9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Tony Luck wrote:

> But memory usage with a 64K page size can get out of hand (especially
> if you have an application that uses a lot of small files).  Dave Kleikamp's
> tail pages would help make 64K page size more generally palatable.

Sure but there is no need for something like that on IA32 since the 
hardware does not support more than 4k.

