Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVHZPpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVHZPpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVHZPpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:45:43 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:3347 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965085AbVHZPpm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:45:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jXlUW8wL3fvhb06vg5cy+0TKS4CkcVKnNcXZcyZppvmui8MaxgYr9Y8ll/cypmPhs9x4SPxB8854FFDutY7q6rwD7ZRJPLd5cz7LV29+f2Oq3NjWfbULkF5ftHdQF12z7nyvyLHrtcWHMUfIlSNqPvSLVoQLvNZ800wD7P5oEQs=
Message-ID: <1132fcd605082608455081c769@mail.gmail.com>
Date: Fri, 26 Aug 2005 23:45:41 +0800
From: lab liscs <liscs.lab@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: my view about schedule( ) and system call , right or wrong ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedule( ) always runs in kernel space, therefore  the address of all
elements used by schedule() is not virtual address but physical
address.?
 
 
analogous question also appears in system call , when I define myself
syscall , for example:
 
asmlinkage long sys_check(a,b ,c){
 
        unsigned long buf;
 
        ...........
}
 
then , the buf is stored in kernel space , that is , physical address .
 
 
right or wrong
