Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUFHVCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUFHVCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUFHVCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:02:11 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:6069 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265268AbUFHVCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:02:07 -0400
Message-ID: <40C6295B.10101@blue-labs.org>
Date: Tue, 08 Jun 2004 17:02:19 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: linux/wrapper.h, where does it come from?
Content-Type: multipart/mixed;
 boundary="------------050905020604020602030505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905020604020602030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Whilst trying to emerge a package recently, it failed due to a missing 
include file.  Searching 2.6.7-rc2 source, I see two references to 
<linux/wrapper.h>, but no actual wrapper.h file except for the IrDA 
wrapper.h file.

sound/oss/swarm_cs4297a.c:#include <linux/wrapper.h>
sound/oss/au1000.c:#include <linux/wrapper.h>

These two files include it.  While compiling the qc-usb module, it's 
searching for this file.

Any takers?

Thanks


--------------050905020604020602030505
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------050905020604020602030505--
