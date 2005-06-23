Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVFWAKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVFWAKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVFWAKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:10:09 -0400
Received: from fmr22.intel.com ([143.183.121.14]:38838 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261156AbVFWAJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:09:20 -0400
Message-Id: <200506230009.j5N09Hg11772@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Update: Industry db benchmark result
Date: Wed, 22 Jun 2005 17:09:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV3hDaw5pwRRpShSHu/LFhAbB+HeAAAgsIg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <p738y12arff.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote on Wednesday, June 22, 2005 4:44 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > 
> > It's been hovering around -13%.  
> 
> Do you have an educated guess where the 13% loss is comming from? 

Process scheduler is the prime suspect. Earlier scheduler experiments
on top of 2.6.11 showed that it was about 10% regression.  Similar
experiments repeated on top of 2.6.12-rc4 indicated about a much
smaller 4%.  Other area are O_DIRECT (2%), and possibly scsi.

- Ken

