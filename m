Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270493AbUJUKId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270493AbUJUKId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270108AbUJUKG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:06:57 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:25184 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270649AbUJUKFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:05:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kFpWEWqNrBvXqKmX99zV5vtYQJfavhwfvKZB7XOH1LedCNXPeUIc2A1h9GHz0XnG+RkXlANqzUgq17Z/cdMTeUL8Ir7e0GreZppop+7Hwis676jWa397jaiJgrLDQbFk30Jlf66qNdg2IISDCSK7G74EylDeC8mvWMETELpK5LY=
Message-ID: <e7b30b24041021030535925d1d@mail.gmail.com>
Date: Thu, 21 Oct 2004 18:05:19 +0800
From: Mildred Frisco <mildred.frisco@gmail.com>
Reply-To: Mildred Frisco <mildred.frisco@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: making a linux kernel with no root filesystem
In-Reply-To: <e7b30b2404102102466dc71118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e7b30b2404102102466dc71118@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to ask help in compiling a minimal linux kernel.
Basically, it would only contain the kernel andno filesystem (or
probably devfs).  I would only have to boot the kernel from floppy.
Then after the necessary kernel initializations, I would issue a
prompt where I can either shutdown or reboot the system. That's the
only functionality required.  As I've learned from the init program
(and startup scripts), the init services and shutdown commands are
called from /sbin. However, I do not require to mount the root fs
anymore.  I also tried to search for the source code of the shutdown
program but I can't find it.  Please help on the steps that I should
do.
Thanks in advance.
Please CC my email add in the reply. Thanks

Mildred <mildred.frisco@gmail.com>
