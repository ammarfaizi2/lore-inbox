Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTJNBcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTJNBcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:32:33 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31918 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262129AbTJNBcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:32:32 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Linux Kern <linux-kernel@vger.kernel.org>
Date: Tue, 14 Oct 2003 11:32:27 +1000
Subject: VM code question
Message-ID: <20031014013227.GA20406@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a small question wrt some VM code.
source file is include/linux/kernel.h

#define container_of(ptr, type, member) ({                      \
        const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
        (type *)( (char *)__mptr - offsetof(type,member) );})

what is the use of the 0 (zero) in the typeof? I am thinking
that we are casting 0 to (type *) then referencing 'member' of
'type', however why do we require the 0 ?

Just curious

--------------------------------------------------
Darren Williams <dsw@gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
