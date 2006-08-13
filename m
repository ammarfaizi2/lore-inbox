Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWHMTV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWHMTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWHMTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:21:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:42762 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751367AbWHMTV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:21:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZ1SiIBDLZNtZvxewrO45LYr7Zzjc8/kXCq5gyPy5ptPRIdRxSpetgnzW2SDSlanVO2BeltCfbcXVyaF17lEb+bRthIvz7K+AdBGYRDOe56L+BKe6Wz+D5lCFBO6woHKkmoY/gZWEVP32pS4hLkJaSBxOKtxJgd/7hrmA2RjbpQ=
Message-ID: <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
Date: Sun, 13 Aug 2006 21:21:24 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060812214719.GA19156@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
	 <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com>
	 <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
	 <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
	 <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com>
	 <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com>
	 <20060812163834.GA11497@thunk.org>
	 <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com>
	 <20060812214719.GA19156@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> Well, the e2fsck man page isn't intended to be a tutorial.  If someone
> wants to volunteer to write an extended introduction to how e2fsck
> works and what all of the messages mean, I'd certainly be willing to
> work with that person...  So if you're willing to volunteer

I'd love to help others with the same problem that I have.  I know
basically nothing of e2fsck though, and I don't have time to research
and write a whole tutorial.  Maybe there's a wiki somewhere where I
can start something out with a structure and some information
regarding the stuff I've seen?

> or willing to chip in to pay for a technical writer, let me know....

What kind of economic scale where you thinking about?

> (This is open source, which means if people who have the bad manners
> to kvetch that volunteers have done all of this free work for them
> haven't done $FOO will be gently reminded that patches to implement
> $FOO are always welcome.  :-)

OTOH, the open source community rigorously PR Linux as an alternative
to Windows.

While the above attitude is fine by me, you're going to have to expect
to see some sad faces from Windows users when they create a filesystem
on a loop device and don't realize that the loop driver destroys
journaling expectancies and results in all their photos and home
videos going down the drain, all because nobody implemented a simple
"warning!" message in the software.

(Or whatever.  Lots of similar examples exist to show you that the "no
warranty: you use our software, you learn to hack it to do what you
want yourself or it's your own fault" argument is fallacious.)
