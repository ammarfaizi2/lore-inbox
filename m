Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278278AbRJSDAM>; Thu, 18 Oct 2001 23:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278282AbRJSDAC>; Thu, 18 Oct 2001 23:00:02 -0400
Received: from eleusis.ucs.uwa.edu.au ([130.95.128.4]:24587 "HELO
	eleusis.ucs.uwa.edu.au") by vger.kernel.org with SMTP
	id <S278280AbRJSC7x>; Thu, 18 Oct 2001 22:59:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Toivo Pedaste <toivo@eleusis.ucs.uwa.edu.au>
Organization: UWA
To: linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Date: Fri, 19 Oct 2001 11:00:09 +0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0110191100090D.09386@eleusis.ucs.uwa.edu.au>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>On Thursday October 18, twalberg@mindspring.com wrote:
>> A semi-random thought on the tree-quota concept:
>> 
>> Does it really make sense to charge a tree quota to a single specific
>> user? I haven't really looked into what would be required to implement
>> it, but my mental picture of a tree quota is somewhat divorced from the
>> user concept, other than maybe the quota table containing a pointer to
>> a contact for quota violations. The bookkeeping might be easier if each
>> tree quota root just held a cumulative total of allocated space, and
>> maybe a just a user name for contacts (or on the fancier side, a hook
>> to execute something...).



>However I actually want to charge usage to users.
>There is a natural mapping from users to directory trees via the
>concept of the home-directory.  It is home directories that I want to
>impose quotas on.  So it seems natural to charge space usage to a
>users.


The use I can see for tree quotas whould be quite divorced from
accounts or users. Currently if you want limit the amount of
space the say /tmp, /home or /var/mail uses you need to put
it on a separate partition, but if you could put a quota 
on a tree you'd have a much more flexible systema adminstration
tool to control the disk space used by each particular function.

I quite like the idea of the quota being related to an inode.
-- 
 Toivo Pedaste                        Email:  toivo@ucs.uwa.edu.au
 University Communications Services,  Phone:  +61 8 9 380 2605
 University of Western Australia      Fax:    +61 8 9 380 1109
"The time has come", the Walrus said, "to talk of many things"...
