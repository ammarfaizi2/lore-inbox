Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTKDJ3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTKDJ3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:29:23 -0500
Received: from gate.firmix.at ([80.109.18.208]:20617 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S264024AbTKDJ3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:29:09 -0500
Subject: Re: All filesystems hang under long periods of heavy load (read
	and write) on a filesystem
From: Bernd Petrovitsch <bernd@firmix.at>
To: Shirley Shi <shirley@kasenna.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FA6E8CE.6040208@kasenna.com>
References: <3FA6E8CE.6040208@kasenna.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067938084.8301.6.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 10:28:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 2003-11-04 at 00:46, Shirley Shi wrote:
> filesystem(ext2 or XFS) since we need do some tests for the storage. Is 
> half day, onn the beginning, the system was running well. But after 
> running the script for a long time, such a half day, one day or two 
> days,  all filesystems would get hung, including the root filesystem 
> although I didn't do any heavy load on it. The file(M.1) I used for 
> reading and writing is about 2.5GB.

Wild guess: Perhaps a memory leak somewhere in the kernel and it shows
up after $BIG_NUMBER of operations?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
