Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTIITr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTIITr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:47:57 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:43702 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264318AbTIITrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:47:55 -0400
Message-ID: <3F5E2E6F.6050803@wmich.edu>
Date: Tue, 09 Sep 2003 15:47:59 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scsi.h type problems?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in scsi.h there on line 215 is a list of variabls of type u8, now this 
is not defined as a type anywhere in scsi.h and with the only include (2 
includes i might add) is types.h.  This file does not define any type 
u8, rather there is a type __u8 that defines u_int8_t.  This looks like 
a mistake in scsi.h to me. Is there any reason why this is not wrong?



This is found in vanilla kernels from at least test4 and i bet further 
back as well.

