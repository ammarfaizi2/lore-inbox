Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbSIYBeV>; Tue, 24 Sep 2002 21:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSIYBeU>; Tue, 24 Sep 2002 21:34:20 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:2011 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S261876AbSIYBeU> convert rfc822-to-8bit; Tue, 24 Sep 2002 21:34:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Using ATAPI 6 "SET MAX EXT" Command and HDIO_DRIVE_CMD ioctl
Date: Tue, 24 Sep 2002 18:39:26 -0700
Message-ID: <E940772158AFE243A3D8D0A741236D4B06CEB1@irv-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using ATAPI 6 "SET MAX EXT" Command and HDIO_DRIVE_CMD ioctl
Thread-Index: AcJkNF/ZBWZ+zMQHRuGJQWhtn+z92g==
From: "David Christensen" <David_Christensen@Phoenix.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Sep 2002 01:39:27.0328 (UTC) FILETIME=[627DBE00:01C26434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to issue the ATAPI 6 "SET MAX EXT" command using the HDIO_DRIVE_CMD ioctl?  As of 2.4.18 kernel, there doesn't seem to be a way to write the high order bytes to the IDE controller to implement the command for a 48bit LBA drive.  Would HDIO_DRIVE_TASKFILE work instead?

David Christensen
