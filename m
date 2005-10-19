Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVJSQHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVJSQHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVJSQHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:07:25 -0400
Received: from [67.137.28.189] ([67.137.28.189]:17536 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751138AbVJSQHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:07:25 -0400
Message-ID: <43565C1F.7000600@soleranetworks.com>
Date: Wed, 19 Oct 2005 08:45:51 -0600
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: partition types dsfs forensic file system 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dsfs forensic file system uses the following partition types.

0x97     Primary Slot Capture Partition
0x98     Distributed Archive/Clustered Slot Store Partition

This information is provided for utilities folks who may need to 
identify these partition types
in existing utilities.  Data offsets are always located at the first 
calculated cylinder boundry within
these partition types.

