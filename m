Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTCJXS5>; Mon, 10 Mar 2003 18:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCJXS5>; Mon, 10 Mar 2003 18:18:57 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:36999 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id <S261660AbTCJXS4>;
	Mon, 10 Mar 2003 18:18:56 -0500
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
	unless indicated otherwise in the message.
Date: Mon, 10 Mar 2003 17:29:35 -0600
From: Patrick E Kane <kane@urbana.css.mot.com>
To: phoebe-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stack growing and buffer overflows
Message-ID: <20030310172935.A1324@scapula.urbana.css.mot.com>
References: <20030310230012.26391.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030310230012.26391.qmail@linuxmail.org>; from felipe_alfaro@linuxmail.org on Tue, Mar 11, 2003 at 12:00:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OpenBSD guys have been working on closing  buffer overflow holes.
Slashdot has this pointer to a msg from Theo de Raadt: 
http://groups.google.com/groups?selm=b1aq2h%242q9g%241%40FreeBSD.csie.NCTU.edu.tw&output=gplain

    In the last while, a couple of people in OpenBSD have
    been putting some buffer overflow "solutions" into our 
    source tree; under my continual prodding.  I thought I 
    would summarize some of these and how they fit together, 
    since what I have seen written up so far has been
    wildly inaccurate.  (Bad reporter, no cookie).

    These are, in short form:

       1) PROT_* purity
       2) W^X
       3) .rodata
       4) propolice

    ...

I like the idea of turning off execute permission on the stack pages.

PEK
---




  
