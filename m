Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTLPOkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 09:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTLPOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 09:40:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13839 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261660AbTLPOkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 09:40:41 -0500
Message-ID: <3FDF1C03.2020509@aitel.hist.no>
Date: Tue, 16 Dec 2003 15:51:47 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
In-Reply-To: <20031216040156.GJ12726@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

> No Linux [R]AID improves sequential performance.  How would
> reading 65KB from two disks in alternation be faster than
> reading continuously from one disk?
> 
Raid-0 is ideally N times faster than a single disk, when
you have N disks.  Because you can read continuously from N
disks instead of from 1, thereby N-doubling the bandwith.

Wether the current drivers manages that is of course another story.

Helge Hafting


