Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWJDFoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWJDFoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWJDFoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:44:07 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:1475 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S1161076AbWJDFoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:44:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: System hang problem.
Date: Tue, 3 Oct 2006 22:44:04 -0700
Message-ID: <C9A861D62D068643A0F4A7B1BCB38E2C0327B637@US01WEMBX1.internal.synopsys.com>
Thread-Topic: System hang problem.
Thread-Index: Acbnacbcbs8lj5yYQb6cU3EemwIJ2AADTzKA
From: "Manish Neema" <Manish.Neema@synopsys.com>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Keith Mannthey" <kmannth@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 05:44:02.0231 (UTC) FILETIME=[18A6BC70:01C6E778]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What you can often do, if you have one application using much memory, 
> is limiting *this application's* memory usage with ulimit. If the 
> application correctly handles malloc()==NULL, then at least your 
> system will behave stably.

The problem is its different application, different user each time (a
typical large R&D environment). /etc/security/limits.conf allows to set
max resident set size. Is there a way to limit based on the total
virtual size? 

-Manish
