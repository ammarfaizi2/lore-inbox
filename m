Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUFLAyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUFLAyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUFLAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:54:04 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:4326 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264502AbUFLAxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:53:30 -0400
Message-ID: <40CA541A.6030808@blue-labs.org>
Date: Fri, 11 Jun 2004 20:53:46 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040609
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [culprit found] Re: [boot hang] 2.6.7-rc2, VIA VT8237
References: <40C0D8FE.7040009@blue-labs.org> <200406042238.04100.bzolnier@elka.pw.edu.pl> <40C0DEC0.90805@blue-labs.org> <40C101D5.3050101@blue-labs.org>
In-Reply-To: <40C101D5.3050101@blue-labs.org>
Content-Type: multipart/mixed;
 boundary="------------030500060503060200090201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030500060503060200090201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Culprit found.  If CONFIG_IOMMU_DEBUG is enabled, the machine will hang 
on boot at the partition check when using the VIA driver.

David Ford wrote:

> Both 2.6.5 and 2.6.7 will boot using the GENERIC IDE driver.  I 
> haven't yet gotten any kernel to not lock up using the VIA driver.


--------------030500060503060200090201
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


--------------030500060503060200090201--
