Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSJCWXu>; Thu, 3 Oct 2002 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJCWXu>; Thu, 3 Oct 2002 18:23:50 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:62392 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261382AbSJCWXt>; Thu, 3 Oct 2002 18:23:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 16:56:37 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler> <20021002224343.GB16453@kroah.com>
In-Reply-To: <20021002224343.GB16453@kroah.com>
MIME-Version: 1.0
Message-Id: <02100316563708.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 17:43, Greg KH wrote:
> Some comments on the code:

> 	- The #ifdef EVMS_DEBUG lines are still in AIXlvm_vge.c, I
> 	  thought you said you were going to fix this file up?
> 	- The OS2 and S390 files don't look like they have been fixed,
> 	  like you said you would before submission.

Greg,

I have finished the cleanup and port to 2.5 for the OS2 plugin. AIX has also 
gone through some cursory cleanup, and the #ifdef's you mentioned should be 
gone. If you're still interested, please take a look and let me know if that 
is more along the lines of what you are looking for. The 390 plugin will 
hopefully come tomorrow.

Bitkeeper: http://evms.bkbits.net/linux-2.5
CVS: http://sourceforge.net/cvs/?group_id=25076
       or
     http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/evms/runtime/linux-2.5/

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
