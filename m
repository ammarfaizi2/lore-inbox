Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbQKSRAF>; Sun, 19 Nov 2000 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132637AbQKSQ7z>; Sun, 19 Nov 2000 11:59:55 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:12584 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132593AbQKSQ7f>; Sun, 19 Nov 2000 11:59:35 -0500
Message-ID: <3A17FFDD.4532574B@linux.com>
Date: Sun, 19 Nov 2000 08:29:17 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gianluca Anzolin <g.anzolin@inwind.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: XMMS not working on 2.4.0-test11-pre7
In-Reply-To: <20001119150645.A732@fourier.home.intranet>
Content-Type: multipart/mixed;
 boundary="------------F7EEDCD7538677862E674069"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F7EEDCD7538677862E674069
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

My guess is that it's a plugin, the source for xmms doesn't have "cpuinfo" anywhere in it.

-d

Gianluca Anzolin wrote:

> it seems there has been a change in the format of the /proc/cpuinfo file: infact 'flags: ' became 'features: '
>
> This change broke xmms and could broke any other program which relies on /proc/cpuinfo...
>
> I hope the problem will be solved (in the kernel or in every other program which uses /proc/cpuinfo) soon...

--------------F7EEDCD7538677862E674069
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------F7EEDCD7538677862E674069--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
