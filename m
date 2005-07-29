Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVG2ByV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVG2ByV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 21:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVG2ByL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 21:54:11 -0400
Received: from fmr24.intel.com ([143.183.121.16]:58339 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261895AbVG2Bxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 21:53:38 -0400
Message-Id: <200507290153.j6T1rYg03861@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Thu, 28 Jul 2005 18:53:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWT31Yf7rxi/7dtS46io25jtcisMQAAG5Pg
In-Reply-To: <42E98A6B.2090305@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, July 28, 2005 6:46 PM
> I'd like to try making them less aggressive first if possible.

Well, that's exactly what I'm trying to do: make them not aggressive
at all by not performing any load balance :-)  The workload gets maximum
benefit with zero aggressiveness.

