Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbULCSG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbULCSG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbULCSG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:06:28 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:62158 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262449AbULCSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:06:27 -0500
Subject: Kernel panic - not syncing: Attempting to free lock with active
	block list
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@linux.kernel.org
Content-Type: text/plain
Message-Id: <1102097193.3540.4.camel@smfhome1.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Fri, 03 Dec 2004 12:06:33 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know what the attempt of the kernel message is, what is it
supposed to mean - 

Kernel panic - not syncing: Attempting to free lock with active block
list

It started showing up running locktests over cifs only after some byte
range locking changes were made to the VFS (outside cifs) a few months
ago.

