Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUGDWSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUGDWSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUGDWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:18:55 -0400
Received: from mx2.magma.ca ([206.191.0.250]:31166 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S265817AbUGDWSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:18:53 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Jesse Stockall <stockall@magma.ca>
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
In-Reply-To: <1088979061.1277.6.camel@localhost>
References: <1088979061.1277.6.camel@localhost>
Content-Type: text/plain
Message-Id: <1088979472.8606.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Jul 2004 18:17:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-04 at 18:11, Ali Akcaagac wrote:
> Yeah here the .config snipplet. But I still wonder how this influences mounting an msdos or vfat partition. Unfortunately I am no expert in FAT related stuff but I assume that textual stuff stored in a filesystem shouldn't affect mounting and unmounting. The only thing NLS changes in a filesystem is special charakters for filenames but it doesn't change the technical structure of the FS itself so in worst case I only get some strange characters shown in filenames.
> 

Do you have both nls_cp437 and nls_iso8859_1 modules loaded?

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

