Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbUKVSUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUKVSUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbUKVSSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:18:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59806 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262259AbUKVSRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:17:09 -0500
Date: Mon, 22 Nov 2004 19:16:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Waitz <tali@admingilde.org>
cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
In-Reply-To: <20041122143720.GL19738@admingilde.org>
Message-ID: <Pine.LNX.4.53.0411221916290.27104@yvahk01.tjqt.qr>
References: <2c59f00304112205546349e88e@mail.gmail.com>
 <20041122143720.GL19738@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  A straight forward question. Wouldn't adding a "file as a directory"
>> mechanism more logical in VFS itself, rather than having each fs (like
>> reiser4) to implement it seperately?
>
>wouldn't it be better if such things would be implemented in a library?
>use gnome-vfs, or try to get a vfs layer into libc.
>That way you can even support different and old kernels and all
>filesystems.
>
>The kernel already provides all methods that are neccessary to do that.
>So there is no need to implement it in the kernel.


*cough* FUSE... *cough*




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
