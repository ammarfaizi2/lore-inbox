Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTJNQum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTJNQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:50:41 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:58004 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262592AbTJNQuk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:50:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI in -pre7 builds with -Os
Date: Tue, 14 Oct 2003 09:50:30 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84702C93046@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI in -pre7 builds with -Os
Thread-Index: AcOR9G2lp9gGLLl1QDmnQfmbAnOZSAAfrCCQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <earny@net4u.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Oct 2003 16:50:30.0782 (UTC) FILETIME=[4712E1E0:01C39273]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Ernst Herzberg
> > ACPI_CFLAGS := -Os
> >
> > Uh ?
> 
> Looks like a bug. And a missing feature.
> 
> - ACPI_CFLAGS := -Os
> + ACPI_CFLAGS := -Os --bzip2

What does that do, excatly? (Obviously compression-related...) I
couldn't find it in the gcc 3.2.2 documentation, is it new?

Regards -- Andy
