Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVCHTFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVCHTFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCHTFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:05:49 -0500
Received: from moritz.faps.uni-erlangen.de ([131.188.113.15]:44653 "EHLO
	moritz.faps.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261518AbVCHTFo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:05:44 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: Writing data > PAGESIZE into kernel with proc fs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 8 Mar 2005 20:05:42 +0100
Message-ID: <09766A6E64A068419B362367800D50C0B58A4F@moritz.faps.uni-erlangen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Writing data > PAGESIZE into kernel with proc fs
thread-index: AcUkEdNbBcV8JJD2QwmEFsgwF3XHQw==
From: "Weber Matthias" <weber@faps.uni-erlangen.de>
To: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any chance to signal an EOF when writing data to kernel via proc fs? Actually if the length of data is N*PAGE_SIZE it seems not to be detectable. I followed up the "struct file" but haven't found anything that helped...

Any help would be appreciated!

Bye
Matthias

