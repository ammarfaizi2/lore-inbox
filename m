Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVIEWdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVIEWdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 18:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVIEWdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 18:33:09 -0400
Received: from colibri.its.UU.SE ([130.238.4.154]:37867 "EHLO
	colibri.its.uu.se") by vger.kernel.org with ESMTP id S964883AbVIEWdH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 18:33:07 -0400
From: Thorild Selen <thorild@Update.UU.SE>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
In-Reply-To: <20050904193350.GA3741@stusta.de>
References: <4IcUz-7H2-27@gated-at.bofh.it> <4J2gx-3zf-3@gated-at.bofh.it>
	<4J5R1-cH-21@gated-at.bofh.it> <4J6ao-L9-21@gated-at.bofh.it>
	<4J6jZ-Xg-11@gated-at.bofh.it> <4J8vt-43Y-13@gated-at.bofh.it>
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com> <20050904193350.GA3741@stusta.de>
Date: Tue, 06 Sep 2005 00:32:32 +0200
Message-ID: <x3ky86b5enz.fsf@Psilocybe.Update.UU.SE>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:
> Please name situations where 8K stacks may be preferred that do not 
> involve binary-only modules.

How about NFS-exporting a filesystem on LVM atop md?  I believe it has
been mentioned before in discussions that 8k stacks are strongly
recommended in this case.  Are those issues solved?


Thorild Selén
Datorföreningen Update / Update Computer Club, Uppsala, SE
