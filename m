Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVAEOBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVAEOBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVAEOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:01:49 -0500
Received: from pcsmail.patni.com ([203.124.139.197]:28600 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S262432AbVAEOBn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:01:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Purpose of do{}while(0) in #define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
Date: Wed, 5 Jan 2005 19:31:44 +0530
Message-ID: <374639AB1012AA4C840022842AA95BC203E0E7E3@ruby.patni.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Thread-Index: AcTuiWOlr8c8AcoCTNGoop5jFCw+jgns5A/w
From: "Kotian, Deepak" <Deepak.Kotian@patni.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just for information, may be very simple.

Is there any specific reason why do{}while(0) is 
there in this definition
#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)

What could happen if it is replaced by
#define spin_lock_init(x)	{ (x)->lock = 0; } 

There are couple of other places, where this kind of usage
is observed in the kernel code.

Thanks and Regards
Deepak



