Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310433AbSCBUGu>; Sat, 2 Mar 2002 15:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSCBUGk>; Sat, 2 Mar 2002 15:06:40 -0500
Received: from relay1.mail.twtelecom.net ([207.67.10.252]:21009 "HELO
	relay1.mail.twtelecom.net") by vger.kernel.org with SMTP
	id <S310433AbSCBUG3>; Sat, 2 Mar 2002 15:06:29 -0500
Subject: kernel thread --> user process
From: Joel Hollingsworth <jhollingsworth@elon.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 02 Mar 2002 15:06:27 -0500
Message-Id: <1015099588.24535.175.camel@trumpy.elon.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I would like to push a kernel thread into a user-level process through
the use of execve. The kernel thread is started from a loadable 
module - so there has been no user-level process dipping into the 
kernel that we could just replace. 

The process init does something similar. From what I've been reading it
just calls execve() and magically it is a user-level process. Since 
my code does not generate a user-level process I assume there is more
to it than that. Can someone point me in the right direction to 
accomplishing this? Do I need to generate a user-land stack frame? How?

Please cc jhollingsworth@elon.edu as I'm currently not subscribed.

Thanks for reading.

-joel

