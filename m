Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTEFPfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTEFPfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:35:23 -0400
Received: from mx01.netapp.com ([198.95.226.53]:30349 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S263847AbTEFPfP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:35:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: [NFS] processes stuck in D state
Date: Tue, 6 May 2003 08:47:28 -0700
Message-ID: <482A3FA0050D21419C269D13989C611312747A@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] processes stuck in D state
Thread-Index: AcMT5ioAdLUgy5P6TH++TGwmCKqKbwAAGOcw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Michael Buesch" <fsdeveloper@yahoo.de>
Cc: <nfs@lists.sourceforge.net>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Zeev Fisher" <Zeev.Fisher@il.marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To reproduce the problem:
> - - mount some nfs from a server in your lan.
> - - Open an app, that uses the mounted fs. I've simply opened a
>   konqueror-window for the directory where the nfs is mounted.
> - - shut down or crash the server or just pull the network-cable.
> - - Now the konqueror-process is nonkillable in D state. There's no
>   chance to kill it.

does the problem persist after you reconnect the network cable?
what happens when the server becomes available again?
are you mounting with UDP or TCP?
