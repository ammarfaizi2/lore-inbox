Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSCNNwD>; Thu, 14 Mar 2002 08:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311563AbSCNNvx>; Thu, 14 Mar 2002 08:51:53 -0500
Received: from alpha1.ebi.ac.uk ([193.62.196.122]:1547 "EHLO alpha1.ebi.ac.uk")
	by vger.kernel.org with ESMTP id <S311619AbSCNNvn>;
	Thu, 14 Mar 2002 08:51:43 -0500
Message-Id: <200203141351.NAA257264@alpha1.ebi.ac.uk>
Content-Type: text/plain; charset=US-ASCII
From: Jonathan Barker <jbarker@ebi.ac.uk>
Reply-To: jbarker@ebi.ac.uk
Organization: EMBL-EBI
To: linux-kernel@vger.kernel.org
Subject: VFS mediator?
Date: Thu, 14 Mar 2002 14:52:04 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

In brief: a kernel module which "exported" VFS requests to a (specified) 
user-space daemon would be useful. My particular application is a daemon 
which generates files on the fly - I would like to expose this as part of the 
filesystem. Ideally, the kernel module would deal with generation of fake 
inode numbers etc and the user-space daemon would simply be asked to create a 
pipe corresponding to a "filename" and (possibly) supply a directory tree. 

Clearly, an application-specific module could do the job - cf NFS. But I am 
not (yet) skilled enough in kernel development to know how, and it seems to 
me that a "VFS mediator" module could simplify development of many 
VFS-related applications (eg mounting ftp sites). Is there a kind soul out 
there who has already done this, or is willing to undertake such a task? 

Thanks for any input

Jonathan

Dr Jonathan Barker
EMBL-EBI Hinxton
jbarker@ebi.ac.uk

 
