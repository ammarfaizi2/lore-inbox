Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKWTLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKWTLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKWTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:09:25 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:33470 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261431AbUKWTA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:00:29 -0500
Message-ID: <41A388CA.7000004@namesys.com>
Date: Tue, 23 Nov 2004 11:00:26 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dirk Steinberg <dws@steinbergnet.net>
CC: reiserfs-list@namesys.com, Valdis.Kletnieks@vt.edu,
       Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com> <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu> <41A23566.6080903@namesys.com> <200411231011.21652.dws@steinbergnet.net>
In-Reply-To: <200411231011.21652.dws@steinbergnet.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Steinberg wrote:

>How about making metas a mount option? 
>
That was always the intention.  I thought it got implemented, sigh, my 
guys need smaller todo lists....

>Right now disabling metas 
>requires patching the source.
>
>/Dirk Steinberg
>  
>
You mean, enabling it requires changing a #define (if you are using the 
latest).  We changed that after bugs were found in the implementation 
that could cause crashes.

Hans
