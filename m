Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWBJNGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBJNGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBJNGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:06:12 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:63410 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932076AbWBJNGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:06:10 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYuQr5p5N5K5CK2QIClvXPXvfTYEQ==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43EC8FBA.1080307@bfh.ch>
Date: Fri, 10 Feb 2006 14:06:02 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <linux-kernel@vger.kernel.org>
Subject: RFC: disk geometry via sysfs
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 13:06:02.0117 (UTC) FILETIME=[BE3F3350:01C62E42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I don't want to start another geometry war, but with the introduction of
the general getgeo function by Christoph Hellwig for all disks this
simply would become a matter of extending the basic gendisk block driver.

There are people out there (like me) who need to know about disk
geometry. But since this is clearly post 2.6.16 I prefer to ask here
before writing a patch...

Q1: Yes or No?
If no, the other questions do not apply

Q2: Where under sysfs?
Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
there be a new sub-object like /sys/block/hdx/geometry/heads?

Q3: Writable?
Under some (weird) circumstances it would actually be quite nice to
overwrite the kernels idea of a disks geometry. This would require a
general function like setgeo. Acceptable?

Regards
Philippe Seewer
