Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVE0Rdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVE0Rdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVE0Rdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:33:51 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:45295 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262533AbVE0Rdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:33:41 -0400
Message-ID: <42975945.7040208@davyandbeth.com>
Date: Fri, 27 May 2005 12:30:45 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disowning a process
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  I'm not sure if there's a posix way of doing this, but wanted to 
check if there is a way in linux.

I want to have a daemon that fork/execs a new process, but don't want 
(for various reasons) the responsibility for cleaning up those process 
with the wait() function family.   I'm assuming that if the init process 
became the parent of one of these forked processes, then it would clean 
them up for me (is this assumption true?).    Besides the daemon process 
exiting, is there a way to disown the process on purpose so that init 
inherits it?

Thanks,
   Davy

