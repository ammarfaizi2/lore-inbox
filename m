Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWDFHeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWDFHeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 03:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWDFHeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 03:34:07 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:10818 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbWDFHeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 03:34:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=soWUERi69Hidom/0l8k160L44l5MY1eHMqNqDfW1lisJ4BfWGB8C8ASCnMvVKEXPVXYReA5Kr9ONkwX+v4XGxdIzh7mGA95i7LoIyT61FlAb0HXaL8fcueZIHVHZusibZNeX8mKvApbMPn4B67nBF3Kom41f6d//A1Gy7tUk2GQ=
Message-ID: <f066e8e40604060034g7df5a9aau4f58f4fb01e2642a@mail.gmail.com>
Date: Thu, 6 Apr 2006 15:34:05 +0800
From: "Maze Maze" <linuxmaze@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SCSI Bidirectional data transfer
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using redhate linux (kernel 2.4.20)

SCSI supports bidirectional data transfer. However, the two variants
request_bufflen and bufflen of a scsi_cmd are set to be the same in
the scsi_init_cmd_from_req(). I am wondering if i want to send and
receive data with different lengths, how do i pass the lengths to SCSI
layer? The scsi_wait_req() accepts only one length.... Can I make use
of extended CDB? Thanks!

Maze
