Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbUKFTbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUKFTbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUKFTbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:31:50 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:22749 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261447AbUKFTbt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:31:49 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: shmem_file_setup not exported
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sat, 06 Nov 2004 20:31:48 +0100
Message-ID: <yw1xactuojtn.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this change in mm/shmem.c:

-EXPORT_SYMBOL(shmem_file_setup);

Is there a reason for this, other than nobody using it?

I used that function in a module I wrote, mostly as a proof of
concept, for someone who was looking for a way to unmap memory pages
while retaining their contents, and being able to map them later.

-- 
Måns Rullgård
mru@inprovide.com
