Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUFXLnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUFXLnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUFXLnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:43:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27032 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264275AbUFXLnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:43:23 -0400
Message-ID: <40DABE5A.6040603@namesys.com>
Date: Thu, 24 Jun 2004 15:43:22 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.7-mm[12]] kernel BUG at include/linux/list.h:164!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

It appears regularly when I try to compile 
http://thebsh.namesys.com/snapshots/2004.03.26/reiser4progs-0.5.3.tar.gz

Well, on 2.6.7-mm1 it breaks easier. on 2.6.7-mm2 - it manages to 
compelte once.

(gdb) bt
#0  0xc013c75a in anon_vma_unlink (vma=0xcdb7a3c0) at 
include/linux/list.h:164
Cannot access memory at address 0xc013c738

Has anyone ever seen something similar? Is there workaround already?
I would be glad to perform any tests to help fixing this



