Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVKTPHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVKTPHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKTPHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:07:00 -0500
Received: from web31013.mail.mud.yahoo.com ([68.142.201.71]:38309 "HELO
	web31013.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751244AbVKTPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:07:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mST9Rs3EPmD9pK+wFrTafT6A8hnM4B7jIe2B0o/fnzlJt1XR3I6vHlwXrF34hTCyuogewJ9GVOKw3tFOWFG0wvjJHvcZCbp7XJVKtwHSkvIofhF8iu5CW73tMtNkdXXxZx3a9iVi2ZLoZA1Y8IHoJspaw8+Ojfs0BNYIf3Y8L7g=  ;
Message-ID: <20051120150657.39568.qmail@web31013.mail.mud.yahoo.com>
Date: Sun, 20 Nov 2005 07:06:57 -0800 (PST)
From: loop lopy <oferstu@yahoo.com>
Subject: A question about comm and verifing user memory address inside a system call
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a few question I would appreaciate if you help
me with.

I need to add my own system call to the kernel.
I know how to do it, but I have a few problems.
First, I need to pass a null terminated string address
to the system call by the wrapper, which calls
int0x80.
Related to that string there is something called
'comm', however I havent found what is comm that is
related to the NULL terminated string or system call.
So, what can comm be?
Secondly, when I need to verify that the memory
address of string, passed as paramter is valid.
I can use access_ok, but is it enough just to check if
copy_from_user is successful?
So, I actually don't need to use access_ok?

I am not subscribed with the list, so I need that the
replies will be personally CC'ed (not sure exactly
what that means).

Thanks for any help and reply.
Ofer.



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
