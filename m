Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVBLO0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVBLO0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBLO0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:26:14 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:63037 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261404AbVBLO0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:26:12 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Using O_DIRECT for file writing in a kernel module
Date: Sat, 12 Feb 2005 07:26:01 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C206392911@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using O_DIRECT for file writing in a kernel module
Thread-Index: AcUQs5eHrvinjMrPQnaOpVnrex/m9AAWwEEQ
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Feb 2005 14:26:02.0692 (UTC) FILETIME=[C7A99040:01C5110E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 17:58 -0700, Hanson, Jonathan M wrote:
> 	I'm trying to write to a file with the O_DIRECT flag from a
> kernel module in a 2.4 series of kernel on x86 hardware. I've learned
> that the O_DIRECT flag requires that the amount of data written and
the
> file offset pointer must be multiples of the underlying "block size."


ehhh why are you writing to a file from a kernel module? That's
generally considered a really bad idea....

[Jon M. Hanson] For what I'm doing I have no other choice but to write
to a file from my kernel module.

