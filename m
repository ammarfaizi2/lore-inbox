Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVGEIqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGEIqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGEIqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 04:46:08 -0400
Received: from mailfe10.tele2.fr ([212.247.155.44]:24270 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261774AbVGEIhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 04:37:08 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Tue, 5 Jul 2005 10:38:57 +0200
From: Frederik Deweerdt <frederik.deweerdt@gmail.com>
To: S <talk2sumit@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       linux prg <linux-c-programming@vger.kernel.org>
Subject: Re: LKM function call on kernel function call?
Message-ID: <20050705083857.GC19742@gilgamesh.home.res>
Mail-Followup-To: S <talk2sumit@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux prg <linux-c-programming@vger.kernel.org>
References: <1458d9610507050123124d6cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1458d9610507050123124d6cb@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/07/05 16:23 +0800, S écrivit:
> I want function1() to be called, everytime the function
> ide_do_rw_disk() of ide-disk.c is called. I do not want to re-compile
> the complete kernel to do this.
> 
You're looking for kprobes 
http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw07Kprobe
Regards,
Frederik Deweerdt
-- 
o---------------------------------------------o
| http://open-news.net : l'info alternative   |
| Tech - Sciences - Politique - International |
o---------------------------------------------o
